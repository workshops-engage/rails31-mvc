# encoding: UTF-8
require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  setup do
    @client = Client.create name: "John", email: "john@gmail.com", password: 'tre543%$#', password_confirmation: 'tre543%$#'
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select "form" do
      assert_select "[action=?]", sessions_path
      assert_select "input[name=?]", "client[email]"
      assert_select "input[name=?]", "client[password]"
      assert_select "input[type=submit]"
    end
  end

  test "should fail" do
    post :create, client: {email: "wrong", password: "wrong"}
    assert_redirected_to new_session_path
    assert_equal flash[:notice], "Usuário ou senha inválidos"
  end

  test "should succeed" do
    post :create, client: {email: "john@gmail.com", password: "tre543%$#"}
    assert_redirected_to root_path
    assert_equal session[:client_id], @client.id
  end

end