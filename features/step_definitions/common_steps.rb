When /^I wait for (\d+) minutes$/ do |arg1|
  sleep(arg1.to_i*60)
end
