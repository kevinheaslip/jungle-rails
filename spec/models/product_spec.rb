require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    before do
      @category = Category.new(name: 'Flowers')
      @category.save
    end

    it 'saves a product successfully with all four fields set' do
      @product = Product.new(
        name: 'Corpse Flower',
        price_cents: 999,
        quantity: 10,
        category: @category
      )
      @product.save
      expect(@product).to be_valid
    end

    it 'requires name to be set' do
      @product = Product.new(
        name: nil,
        price_cents: 999,
        quantity: 10,
        category: @category
      )
      @product.save
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'requires price to be set' do
      @product = Product.new(
        name: 'Corpse Flower',
        price_cents: nil,
        quantity: 10,
        category: @category
      )
      @product.save
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'requires quantity to be set' do
      @product = Product.new(
        name: 'Corpse Flower',
        price_cents: 999,
        quantity: nil,
        category: @category
      )
      @product.save
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'requires category to be set' do
      @product = Product.new(
        name: 'Corpse Flower',
        price_cents: 999,
        quantity: 10,
        category: nil
      )
      @product.save
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
