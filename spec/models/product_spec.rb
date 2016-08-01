require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before :each do
      @category = Category.create!(name: "Furniture")
    end
    it "creates a product" do
      product = Product.create!(name: "Chair", price: 123, quantity: 3, category: @category)
      expect(product.valid?).to eql true
    end
    it "name validation fails when not present" do
      product = Product.new(name: nil, price: 123, quantity: 3, category: @category)
      expect(product.valid?).to eql false
      expect(product.errors.size).to eql 1
      expect(product.errors[:name]).to eql ["can't be blank"]
    end
    it "price validation fails when not present" do
      product = Product.new(name: "Chair", price: nil, quantity: 3, category: @category)
      expect(product.valid?).to eql false
      expect(product.errors.size).to eql 3
      expect(product.errors[:price]).to eql ["is not a number", "can't be blank"]
    end
    it "quantity validation fails when not present" do
      product = Product.new(name: "Chair", price: 123, quantity: nil, category: @category)
      expect(product.valid?).to eql false
      expect(product.errors.size).to eql 1
      expect(product.errors[:quantity]).to eql ["can't be blank"]
    end
    it "category validation fails when not present" do
      product = Product.new(name: "Chair", price: 123, quantity: 3, category: nil)
      expect(product.valid?).to eql false
      expect(product.errors.size).to eql 1
      expect(product.errors[:category]).to eql ["can't be blank"]
    end
  end
end
