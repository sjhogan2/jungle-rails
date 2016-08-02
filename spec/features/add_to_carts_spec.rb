require 'rails_helper'

RSpec.feature "Visitor adds item to cart", type: :feature, js: true do

 # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        image: open_asset('apparel1.jpg'),
        price: 64.99
      )
    end
  end

  scenario "They click on add to cart" do
    # ACT
    visit root_path
    product = page.first("article.product")
    cart = product.first("footer a")
    cart.click

    # DEBUG / VERIFY
    expect(page).to have_text('My Cart (1)')
    save_screenshot

  end

end