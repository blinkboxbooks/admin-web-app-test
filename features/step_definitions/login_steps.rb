Given(/^I am logged in as a (api|CSM|csr|ops|me|ctm|mkt) user$/i) do |role|
  sign_in_page.load
  user_email = test_data('emails', "#{role.downcase}_user")
  password = test_data('passwords', "#{role.downcase}_password")
  sign_in_page.submit(user_email, password, true)
  expect(current_page.header.welcome_message).to be_visible
  expect(current_page.header.user_role_displayed.downcase).to eq(role.downcase)
end