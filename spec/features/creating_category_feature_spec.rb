require 'rails_helper'
require 'support/macros'

RSpec.feature "Creating Categories" do
  
  let(:admin) { Fabricate(:user, admin: true) }
  let(:category) { Fabricate(:category, name: "Programming") }

  scenario "with valid name" do
    visit root_path
    log_in_as(admin)

    click_link "New Category"
    fill_in "Name", with: category.name
    click_button "Create Category"
    expect(Category.count).to eq(1)
    expect(current_path).to eq(categories_path) 
  end


  scenario "with invalid name" do
    visit root_path
    log_in_as(admin)
    click_link "New Category"
    fill_in "Name", with: ""
    click_button "Create Category"
    expect(Category.count).to eq(0)
    expect(page).to have_content("errors prevented from the saving") 
  end

end