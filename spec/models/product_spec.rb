require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it "it saves a product with all four fields successfully" do 
      @category = Category.create(:name => "Shoe")
      @product = Product.create({name: "Pink Shoe", price: 20, quantity: 2, category: @category})
      expect(Product.count).to equal(1)
    end

    it "Does not save with incorrect name fields" do   
      @category = Category.create(:name => "Shoe")
      @product = Product.create({price: 20, quantity: 2, category: @category})
      expect(Product.count).to equal(0)
    end
    it "Does not save with incorrect price fields" do   
      @category = Category.create(:name => "Shoe")
      @product = Product.create({name: "pink show", quantity: 2, category: @category})
      expect(Product.count).to equal(0)
    end
    it "Does not save with incorrect quantity fields" do   
      @category = Category.create(:name => "Shoe")
      @product = Product.create({name: "pink show", price: 20, category: @category})
      expect(Product.count).to equal(0)
    end
    it "Does not save with incorrect category fields" do   
      @category = Category.create(:name => "Shoe")
      @product = Product.create({name: "pink show", price: 20, quantity: 2})
      expect(Product.count).to equal(0)
    end
  end
end
