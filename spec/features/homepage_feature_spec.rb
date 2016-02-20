require 'rails_helper'

RSpec.feature "Creating Home page" do

  scenario do
    visit root_path
    expect(page).to have_link("Sign Up.It's free!")
    expect(page).to have_link("LOGIN")
  end
  
end 