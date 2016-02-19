require 'rails_helper'

RSpec.feature "Signing In" do

  let!(:john) { Fabricate(:user) }

  scenario "with valid credentials" do
    visit "/"
    click_link "LOGIN"

    fill_in "Email", with: john.email
    fill_in "Password", with: john.password

    click_button "Log In"
    expect(page).to have_content("Signed in successfully.")
    expect(current_path).to eq(user_path(john))
  end

  scenario "with invalid credentials" do
    visit "/"
    click_link "LOGIN"

    fill_in "Email", with: ""
    fill_in "Password", with: ""

    click_button "Log In"
    expect(page).to have_content("Invalid email or password.")
    expect(current_path).to eq(new_user_session_path)
  end

end
