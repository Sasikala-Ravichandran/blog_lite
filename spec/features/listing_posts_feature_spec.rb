require 'rails_helper'
require 'support/macros'

RSpec.feature "Listing Posts" do
  
  let!(:user) { Fabricate(:user) }
  let!(:post_1) { Fabricate(:post) }
  let!(:post_2) { Fabricate(:post) }

  scenario "without signing in "do
    visit "/"
    click_link "Posts"
    expect(page).to have_content "#{post_1.title}"
    expect(page).to have_content "#{post_2.title}"
  end

  scenario "with signing in" do    
    log_in_as(user)
    expect(page).to have_content("Signed in successfully.")
    click_link "Posts"
    expect(page).to have_content "#{post_1.title}"
    expect(page).to have_content "#{post_2.title}"
  end

end