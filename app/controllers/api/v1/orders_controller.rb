module Api
  module V1
    class OrdersController < ApplicationController
      before_action :set_client_order, only: %i[ show edit update destroy ]
      

      def show
        item = Order.find(params[:id])
        render json: item
      end
    
      def new
      end

      def create
        ActiveRecord::Base.transaction do
          @client_order = Order.new(client_order_params)
          @cartStocks = params[:cartStocks]

            @client_order.checkStock(@cartStocks) #I check for the stock of each item, can raise rollback
            
              if @client_order.save
                @cartStocks.each do |stock| #I create the order products and reduce the stock
                  @order_product = OrderProduct.new(order_id: @client_order[:id], product_id: stock[:product_id], size: stock[:size], quantity: stock[:amount])
                  unless @order_product.save
                    raise ActiveRecord::Rollback, "Error creating the order product"
                  end
                  @stock = Stock.find_by(id: stock[:id])
                  @stock.reduceStock(stock[:amount]) #can raise rollback
                end
                render json: { notice: "Order was successfully created." }
              else
                raise ActiveRecord::Rollback, "Error creating the order"
              end
        rescue ActiveRecord::Rollback => e
          render json: { error: e.message }, status: :unprocessable_entity
        rescue => e
          render json: { error: "An unexpected error occurred: #{e.message}" }, status: :unprocessable_entity
        end
      end

      def edit
      end

      def update
        respond_to do |format|
          if @client_order.update(client_order_params)
            format.html { render json: { notice: "Order was successfully updated." }}
            format.json { render :show, status: :ok, location: @client_order }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @client_order.errors, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @client_order.destroy
    
        respond_to do |format|
          format.html { render json: { notice: "Order was successfully destroyed." } }
          format.json { head :no_content }
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_client_order
        @client_order = Order.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def client_order_params
        params.require(:order).permit(:customer_email, :fulfilled, :total, :address)
      end
    end
  end
end
