module Api
  module V1
    class StocksController < ApplicationController
      before_action :set_client_product, only: %i[index show]
      
      def show
        items = @product.stocks
        render json: items
      end

      
    
      private

      def set_client_product
        @product = Product.find(params[:id])
      end
    end
  end
end
