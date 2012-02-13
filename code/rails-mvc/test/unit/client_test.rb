# encoding: UTF-8
require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  def create_client
    @client = Client.create! name: "John", email: "john@gmail.com", password: 'tre543%$#', password_confirmation: 'tre543%$#'
  end
  test "validates presence of name" do
    client = Client.new name: nil
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:name].any?
  end
  test "validates presence of email" do
    client = Client.new email: nil
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:email].any?
  end
  test "validates format of email" do
    client = Client.new email: "invalid"
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:email].any?
  end
  test "validates uniqueness of email" do
    create_client
    client = Client.create email: "john@gmail.com"
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:email].any?
  end
  test "validates numericality of age" do
    client = Client.new age: "not a number"
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:age].any?
  end
  test "validates minimum age" do
    client = Client.new age: 17
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:age].any?
  end
  test "validates inclusion of state" do
    client = Client.new state: 'xx'
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:state].any?
  end
  test "validates acceptance of terms" do
    client = Client.new terms: false
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:terms].any?
  end
  test "validates confirmation of password - nil" do
    client = Client.new password: 'hgf654^%$', password_confirmation: nil
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:password_confirmation].any?
  end
  test "validates confirmation of password - wrong" do
    client = Client.new password: 'hgf654^%$', password_confirmation: 'wrong'
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:password].any?
  end
  test "validates strenght of password" do
    client = Client.new password: '111111', password_confirmation: '111111'
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:password].any?
    assert_equal "too weak", client.errors[:password].first
  end
  test "auth" do
    create_client
    assert_equal nil, Client.auth(email: "wrong", password: 'wrong')
    assert_equal nil, Client.auth(email: "john@gmail.com", password: 'wrong')
    assert_equal nil, Client.auth(email: "wrong", password: 'tre543%$#')
    assert_equal @client, Client.auth(email: "john@gmail.com", password: 'tre543%$#')
  end

end