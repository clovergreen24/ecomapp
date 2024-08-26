class Order < ApplicationRecord
  has_many :order_products, dependent: :destroy

  def checkStock(orderStocks)
    orderStocks.each do |orderStock|
      stock = Stock.find(orderStock[:id])
      if !(stock[:amount] >= orderStock[:amount])
        @stockProduct = Product.find(stock[:product_id])
        raise ActiveRecord::Rollback, "Stock not enough for product #{@stockProduct[:name]} in size #{stock[:size]}, only #{stock[:amount]} units available"
      end
    end
  end
end
