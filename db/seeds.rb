# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

puts 'SETTING UP ADMIN LOGIN'
user = User.create! :name => 'Gabe', :email => 'gabe@golahny.org', :password => SENSITIVE_CONFIG[:default_admin_password], :password_confirmation => SENSITIVE_CONFIG[:default_admin_password], :admin => true
puts 'New user created: ' << user.name
