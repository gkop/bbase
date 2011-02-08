Given /^I am a user "([^\"]*)" with email "([^\"]*)" and password "([^\"]*)"$/ do |name, email, password|
  @user = User.create!(:name => name,
           :email => email,
           :password => password,
           :password_confirmation => password)
end

Given /^I am a new, authenticated user$/ do
  email = 'testing@man.net'
  name = 'Testing man'
  password = 'secretpass'

  Given %{I am a user "#{name}" with email "#{email}" and password "#{password}"}
  And %{I go to the homepage}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Sign in"}
end
