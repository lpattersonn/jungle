
require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'
  
    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Visit home page and click on link to see product details" do
    # visit home page
    visit root_path
    # click on details button to go to product details
    first('article.product').find_link('Details »').click
    expect(page).to have_content('Quantity')
    page.save_screenshot
  end
end