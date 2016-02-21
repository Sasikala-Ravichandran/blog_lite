require 'rails_helper'
require 'support/macros'

RSpec.feature "Listing Categories" do
  
  let!(:user) { Fabricate(:user) }
  let!(:category_1) { Fabricate(:category, name: "Sports") }
  let!(:category_2) { Fabricate(:category, name: "Cooking") }

  scenario "without signing in "do
    visit "/"
    click_link "Categories"
    expect(current_path).to eq(categories_path)
    expect(page).to have_link "#{category_1.name}"
    expect(page).to have_link "#{category_2.name}"
  end

  scenario "with signing in" do    
    log_in_as(user)
    expect(page).to have_content("Signed in successfully.")
    click_link "Categories"
    expect(current_path).to eq(categories_path)
    expect(page).to have_link "#{category_1.name}"
    expect(page).to have_link "#{category_2.name}"
  end

end