# encoding: UTF-8
require 'test_helper'

class OrderItemsControllerTest < ActionController::TestCase

  setup do
    @client = Client.create name: "John", email: "john@gmail.com", password: 'tre543%$#', password_confirmation: 'tre543%$#'
    @order = @client.orders.create
    @product = Product.create name: 'Xaxá', price: 0.2
    session[:client_id] = @client.id
    session[:order_id] = @order.id
  end

  test "should create order_item" do
    assert_difference('OrderItem.count') do
      post :create, order_item: {product_id: @product.id, quantity: 1}
    end

    assert_redirected_to order_path(@order)
  end

  test "should update order_item" do
    @order.order_items.create product: @product, quantity: 1
    assert_no_difference('OrderItem.count') do
      post :create, order_item: {product_id: @product.id, quantity: 10}
    end

    assert_redirected_to order_path(@order)
    assert_equal 10, @order.order_items.first.quantity
  end
  test "should destroy order_item" do
    @order_item = @order.order_items.create product: @product, quantity: 1
    assert_difference('OrderItem.count', -1) do
      delete :destroy, id: @order_item.to_param
    end

    assert_redirected_to order_path(@order)
  end
end
