def do_login
  And %{I go to my dashboard}
  And %{I fill in "user_email" with "#{@current_user.email}"}
  And %{I fill in "user_password" with "#{@current_user.password}"}
  And %{I press "Sign in"}
end

Given /^I am a user "([^\"]*)" with email "([^\"]*)" and password "([^\"]*)"$/ do |name, email, password|
  @current_user = User.create!(:name => name,
           :email => email,
           :password => password,
           :password_confirmation => password)
end

Given /^I am a new, authenticated user$/ do
  email = 'testing@man.net'
  name = 'Testing man'
  password = 'secretpass'

  Given %{I am a user "#{name}" with email "#{email}" and password "#{password}"}
  do_login
end

Given /^I am logged in as an? (.+)$/ do |model|
  factory_name = model.gsub(' ', '_')
  @current_user = Factory.create(factory_name)
  do_login
end
