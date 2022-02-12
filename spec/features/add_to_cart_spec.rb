require 'rails_helper'

RSpec.feature "AddProducts", type: :feature, js: true do
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


  scenario "A user can add a product to their cart when not logged in" do
    # visit the home page
    visit '/'
    # find a product listing
    first('article.product').find_button('Add').click
    expect(page).to have_content('My Cart (1)')
    page.save_screenshot
  end
end
