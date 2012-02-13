# encoding: UTF-8
require 'test_helper'

class OrdersControllerTest < ActionController::TestCase

  setup do
    @client = Client.create name: "John", email: "john@gmail.com", password: 'tre543%$#', password_confirmation: 'tre543%$#'
    @order = @client.orders.create
    @xaxa = Product.create name: 'Xaxá', price: 0.2
    @soft = Product.create name: 'Soft', price: 0.3
    @order.order_items.create product: @xaxa, quantity: 1
    @order.order_items.create product: @soft, quantity: 1
    session[:client_id] = @client.id
    session[:order_id] = @order.id
  end

  test "should get show" do
    get :show
    assert_response :success
    assert_select "table#items" do
      assert_select "thead"
      assert_select "tbody" do
        assert_select "tr" do
          assert_select "td", "Xaxá"
          assert_select "td", "1"
          assert_select "td", /0\.2/
        end
        assert_select "tr" do
          assert_select "td", "Soft"
          assert_select "td", "1"
          assert_select "td", /0\.3/
        end
      end
      assert_select "tfoot" do
        assert_select "tr" do
          assert_select "td", /0\.5/
        end
      end
    end
  end

end