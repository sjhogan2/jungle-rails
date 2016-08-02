require 'rails_helper'

RSpec.feature "Visitor navigates to product details", type: :feature, js: true do

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

  scenario "They see that product's details" do
    # ACT
    visit root_path
    product = page.first("article.product")
    product.find("header a").click

    # DEBUG / VERIFY
    expect(page).to have_css('section.products-show')
    save_screenshot

  end

end
