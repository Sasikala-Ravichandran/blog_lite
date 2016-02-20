require 'rails_helper'

RSpec.feature "Creating Home page" do

  scenario do
    visit root_path
    expect(page).to have_link("Sign Up. It's Free!")
    expect(page).to have_link("LOGIN")
    expect(page).to have_link("Posts")
  end
  
end 