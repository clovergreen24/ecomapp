module Api
  module V1
    class ProductsController < ApplicationController
      def index
        items = Product.where(active: true).map(&:as_json)
        render json: items
      end

      def show
        item = Product.find(params[:id]).as_json
        render json: item
      end
    
    end
  end
end
