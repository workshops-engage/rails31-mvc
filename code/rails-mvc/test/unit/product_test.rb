# encoding: UTF-8
require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "validates presence of name" do
    prod = Product.new name: nil
    assert ! prod.valid?, "product should be invalid"
    assert prod.errors[:name].any?
  end
  test "validates presence of price" do
    prod = Product.new price: nil
    assert ! prod.valid?, "product should be invalid"
    assert prod.errors[:price].any?
  end
  test "validates numericality of price" do
    prod = Product.new price: "not a number"
    assert ! prod.valid?, "product should be invalid"
    assert prod.errors[:price].any?
  end

end
