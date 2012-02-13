class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  validates :order, presence: true
  validates :product, presence: true
  validates :quantity, presence: true, numericality: true
  # validates :price, presence: true, numericality: true
  protected
  before_save :set_price_and_total
  def set_price_and_total
    self.price = product.price
    self.total = product.price * quantity
  end
  
end
