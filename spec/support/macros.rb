def sign_in_as(user = nil)
  visit root_path
  click_link "LOGIN"

  fill_in "Email", with: user.email
  fill_in "Password", with: user.password

  click_button "Log In"
end