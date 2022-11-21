require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "should throw no errors to create a product with all required" do
      @category = Category.new(name: "Test")
      @product = @category.products.new(name: "test", price_cents: 500, quantity: 3, category: @category)
      @product.save
      expect(@product.errors.full_messages).to eq([])

    end
    it "should have error message when name is blank" do
      @category = Category.new(name: "Test")
      @product = @category.products.new(name: nil, price_cents: 500, quantity: 3, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it "should have error message when price is blank" do
      @category = Category.new(name: "Test")
      @product = @category.products.new(name: "test", price_cents: nil, quantity: 3, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    it "should have error message when quantity is blank" do
      @category = Category.new(name: "Test")
      @product = @category.products.new(name: "test", price_cents: 500, quantity: nil, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it "should have error message when category is blank" do
      @product = Product.new(name: "test", price_cents: 500, quantity: 30, category: nil)
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
