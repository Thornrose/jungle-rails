require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'is valid with valid attributes' do
      category = Category.new
      @product = Product.new({
        category: category,
        name:  'Product',
        description: "A description for a product",
        quantity: 50,
        price: 29.99
      })
      @product.save!
      expect(@product.id).to be_present
    end

    it 'is not valid without a name' do
      category = Category.new
      @product = Product.new({
        category: category,
        name: nil,
        description: "A description for a product",
        quantity: 50,
        price: 29.99
      })
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'is not valid without a price' do
      category = Category.new
      @product = Product.create({
        category: category,
        name:  'Product',
        description: "A description for a product",
        quantity: 50,
        price_cents: nil
      })
      # puts @product.inspect
      expect(@product.errors.full_messages).to include("Price cents is not a number", "Price is not a number", "Price can't be blank")
    end

    it 'is not valid without a quantity' do
      category = Category.new
      @product = Product.create({
        category: category,
        name:  'Product',
        description: "A description for a product",
        quantity: nil,
        price: 29.99
      })
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'is not valid without a category' do
      @product = Product.create({
        category: nil,
        name:  'Product',
        description: "A description for a product",
        quantity:50,
        price: 29.99
      })
      expect(@product.errors.full_messages).to include("Category must exist", "Category can't be blank")
    end

  end
end
