class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  protected
  before_save :set_price_and_total
  def set_price_and_total
    self.price = product.price
    self.total = product.price * quantity
  end
end
