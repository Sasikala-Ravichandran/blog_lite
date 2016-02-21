require 'rails_helper'
require 'support/macros'

RSpec.feature "Creating Post" do
  
  let(:user) { Fabricate(:user) }
  let!(:post) { Fabricate(:post) }

  scenario "with valid name" do
    visit root_path
    log_in_as(user)

    click_link "New Post"
    fill_in "Title", with: post.title
    fill_in "Description", with: post.description
    check('Arts')
    check('Cooking')

    click_button "Create Post"
    expect(Post.count).to eq(1)
    expect(page).to have_content("Post has been created")
  end

  scenario "with invalid title" do
    visit root_path
    log_in_as(user)

    click_link "New Post"
    fill_in "Title", with: " "
    fill_in "Description", with: post.description
    check('Arts')
    check('Cooking')

    click_button "Create Post"
    expect(Post.count).to eq(0)
    expect(page).to have_content("1 error prevented from the saving")
  end

end