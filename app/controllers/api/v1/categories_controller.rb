module Api
  module V1
    class CategoriesController < ApplicationController
      def index
        items = Category.all.map(&:as_json)
        render json: items
      end
    
    end
  end
end
