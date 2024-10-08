module Api
  module V1
    class StocksController < ApplicationController
      before_action :set_client_product, only: %i[show]
      
      def show
        items = @product.stocks
        render json: items
      end

      def availableStock
        list = params[:stocklist].split(',')
        items = list.map {|id| Stock.find_by(id: id)}
        render json: items
      end
    
      private

      def set_client_product
        @product = Product.find(params[:id])
      end
    end
  end
end
