class Product < ApplicationRecord
    has_one_attached :image do |attachable|
        attachable.variant :thumb, resize_to_limit: [100,100]
    end

    has_many :stocks
    has_many :order_products
    has_one :category

    def as_json(options = {})
        super(options).merge(image_url: image.attached? ? Rails.application.routes.url_helpers.url_for(image) : nil)
    end
end
