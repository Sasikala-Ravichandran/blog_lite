require 'rails_helper'
require 'support/macros'

RSpec.feature "Showing a User Profile" do
  
  let!(:user) { Fabricate(:user) }
  let!(:post_1) { Fabricate(:post) }
  let!(:post_2) { Fabricate(:post) }

  scenario "without signing in "do
    visit "/"
    click_link "Bloggers"
    click_link "#{user.full_name}"
    expect(page).to have_content "#{user.full_name}"
  end

  scenario "with signing in" do    
    log_in_as(user)
    expect(page).to have_content("Signed in successfully.")
    click_link "Bloggers"
    click_link "#{user.full_name}"
    expect(page).to have_content "#{user.full_name}"
  end

end