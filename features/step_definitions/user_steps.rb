def valid_user
  @user ||= {:name=>'Manpreet Minhas',:email=>'javaminhas@gmail.com',:password=>'please',:password_confirmation=>'please'}
end

def sign_up user
  visit '/users/sign_up'
  fill_in 'Email', :with => user[:email]
  fill_in 'Password', :with => user[:password]
  fill_in 'Password confirmation', :with => user[:password_confirmation]
  click_button 'Sign up'
end

Given /^I am not logged in$/ do
  visit '/users/sign_out'
end

When /^I sign up with valid user data$/ do
  sign_up valid_user
end

Then /^I should see a successful sign up message$/ do
  page.should have_content "Welcome! You have signed up successfully."
end
When /^I sign up with invalid email$/ do
  user = valid_user.merge(:email=>'notanemail')
  sign_up user
end
Then /^I should see  an invalid email message$/ do
  page.should have_content "Email is invalid"
end