class Order < ActiveRecord::Base
  belongs_to :client
  has_many :order_items
  def total
    order_items.all.sum &:total
  end
end
