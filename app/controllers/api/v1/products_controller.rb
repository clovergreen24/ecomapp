module Api
  module V1
    class ProductsController < ApplicationController
      def index
        items = Product.all.map(&:as_json)
        render json: items
      end

      def by_category
        items = Product.where(active: true, category_id: params[:id])
        no_stock, stock = items.partition {|item| item.noStock }
        products = stock,no_stock
        products.map(&:as_json)
        render json: products
      end

      def show
        
        item = Product.find(params[:id]).as_json
        render json: item
      end
    
    end
  end
end
