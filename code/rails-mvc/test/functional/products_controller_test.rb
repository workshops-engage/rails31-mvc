# encoding: UTF-8
require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @client = Client.create name: "John", email: "john@gmail.com", password: 'tre543%$#', password_confirmation: 'tre543%$#'
    @order = @client.orders.create
    @xaxa = Product.create name: 'Xaxá', price: 0.2
    @soft = Product.create name: 'Soft', price: 0.3
  end

  test "should get index" do
    session[:client_id] = @client.id
    session[:order_id] = @order.id
    get :index
    assert_response :success
    assert_select "ul#products" do
      assert_select "li a[href=?]", product_path(@xaxa)
      assert_select "li a[href=?]", product_path(@soft)
    end
  end

  test "should get show" do
    session[:client_id] = @client.id
    session[:order_id] = @order.id
    get :show, id: @xaxa
    assert_response :success
    assert_select "h1", "Xaxá"
    assert_select "form" do
      assert_select "[action=?]", order_items_path
      assert_select "input" do
        assert_select "[name=?]", "order_item[quantity]"
        assert_select "[value=?]", "1"
      end
      assert_select "input" do
        assert_select "[name=?]", "order_item[product_id]"
        assert_select "[value=?]", @xaxa.id
      end
    end
  end
end