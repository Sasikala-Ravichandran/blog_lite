require 'rails_helper'

RSpec.feature "Signing Up" do

  scenario "with valid credentials" do
    visit root_path
    click_link "SIGN UP"

    fill_in "First name", with: "John"
    fill_in "Last name", with: "Doe"
    fill_in "Email", with: "johndoe@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_button "Sign up"
    expect(page).to have_content("Welcome! You have signed up successfully.")

  end

  scenario "with invalid credentials" do
    visit root_path
    visit root_path
    click_link "SIGN UP"

    fill_in "First name", with: ""
    fill_in "Last name", with: ""
    fill_in "Email", with: ""
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_button "Sign up"
    expect(page).to have_content("error prohibited this user from being saved")
  end

end