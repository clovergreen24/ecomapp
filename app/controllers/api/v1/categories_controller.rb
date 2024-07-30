module Api
  module V1
    class CategoriesController < ApplicationController
      def index
        items = Category.all.map(&:as_json)
        render json: items
      end
    
      def show
        item = Category.find(params[:id]).as_json
        render json: item
      end
    end
  end
end
