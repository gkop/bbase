Given /^I am a user "([^\"]*)" with email "([^\"]*)" and password "([^\"]*)"$/ do |name, email, password|
  User.new(:name => name,
           :email => email,
           :password => password,
           :password_confirmation => password).save!
end
