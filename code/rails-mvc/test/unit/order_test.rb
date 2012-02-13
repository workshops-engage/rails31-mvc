# encoding: UTF-8
require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "validates presence of client" do
    oi = Order.new client: nil
    assert ! oi.valid?, "item should be invalid"
    assert oi.errors[:client].any?
  end
  test "total" do
    client = Client.create name: "John", email: "john@gmail.com", password: 'tre543%$#', password_confirmation: 'tre543%$#'
    order = client.orders.create
    xaxa = Product.create name: 'Xaxá', price: 0.2
    soft = Product.create name: 'Xaxá', price: 0.3
    order.order_items.create product: xaxa, quantity: 10
    order.order_items.create product: soft, quantity: 10

    assert_equal 5, order.total
  end
end
