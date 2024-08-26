class Stock < ApplicationRecord
  belongs_to :product

  def reduceStock(amount)
    self[:amount] -= amount
    unless self.save
      raise ActiveRecord::Rollback, "Error reducing the stock"
    end
  end
end
