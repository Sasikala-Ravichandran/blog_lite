require 'rails_helper'
require 'support/macros'

RSpec.feature "Signing Out" do

  let!(:john) { Fabricate(:user) }

  scenario "Log out" do

    log_in_as(john)
    visit user_path(john)
    click_link "Logout"
    expect(page).to have_content("Signed out successfully.")
    expect(current_path).to eq(root_path)
  end
end