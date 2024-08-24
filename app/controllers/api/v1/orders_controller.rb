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
        
        @client_order = Order.new(client_order_params)
    
        respond_to do |format|
          if @client_order.save
            format.html { render json: { notice: "Order was successfully created." }}
            format.json { render :show, status: :created, location: @client_order }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @client_order.errors, status: :unprocessable_entity }
          end
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
