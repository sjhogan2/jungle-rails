require 'rails_helper'

RSpec.feature "User logs in", type: :feature, js: true do

 # SETUP
  before :each do
    @user = User.create!({
      name: "Phil",
      email: "phil@phil.com",
      password: "phil"
    })

  end

  scenario "They fill in the login form" do
    # ACT
    visit login_path
    fill_in 'email', with: 'phil@phil.com'
    fill_in 'password', with: 'phil'
    submit = page.find :button, "Submit"
    submit.click

    # DEBUG / VERIFY
    expect(page).to have_text('My Cart (0)')
    save_screenshot

  end

end