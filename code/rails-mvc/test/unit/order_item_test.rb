# encoding: UTF-8
require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  setup do
    @client = Client.create name: "John", email: "john@gmail.com", password: 'tre543%$#', password_confirmation: 'tre543%$#'
    @order = @client.orders.create
    @product = Product.create name: 'Xaxá', price: 0.2
  end
  test "validates presence of order" do
    oi = OrderItem.new order: nil
    assert ! oi.valid?, "item should be invalid"
    assert oi.errors[:order].any?
  end
  test "validates presence of product" do
    oi = OrderItem.new product: nil
    assert ! oi.valid?, "item should be invalid"
    assert oi.errors[:product].any?
  end
  test "validates presence of quantity" do
    oi = OrderItem.new quantity: nil
    assert ! oi.valid?, "item should be invalid"
    assert oi.errors[:quantity].any?
  end
  test "validates numericality of quantity" do
    oi = OrderItem.new quantity: "not a number"
    assert ! oi.valid?, "item should be invalid"
    assert oi.errors[:quantity].any?
  end
  test "set price and total" do
    oi = OrderItem.create! order: @order, product: @product, quantity: 10
    assert_equal 0.2, oi.price
    assert_equal 2, oi.total
  end
end
