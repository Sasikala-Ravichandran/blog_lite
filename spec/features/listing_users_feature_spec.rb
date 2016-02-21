require 'rails_helper'
require 'support/macros'

RSpec.feature "Listing Users" do
  
  let!(:user_1) { Fabricate(:user) }
  let!(:user_2) { Fabricate(:user) }
  let!(:user_3) { Fabricate(:user) }

  scenario "without signing in "do  
    visit "/"
    click_link "Bloggers"
    expect(page).to have_content "All Bloggers"
    expect(page).to have_content "#{user_1.full_name}"
    expect(page).to have_content "#{user_2.full_name}"
  end

  scenario "with signing in" do    
    log_in_as(user_1)
    expect(page).to have_content("Signed in successfully.")
    click_link "Bloggers"
    expect(page).to have_content "All Bloggers"
    expect(page).to have_content "#{user_1.full_name}"
    expect(page).to have_content "#{user_2.full_name}"
  end

end