module Api
  module V1
    class ProductsController < ApplicationController
      def index
        items = Product.all
        render json: items
      end

    
    end
  end
end
