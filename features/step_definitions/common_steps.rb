module WithinHelpers
  def with_scope(locator)
    if locator == "my galleries"
      within(:css, "div#my-galleries") { yield }
    elsif locator == "the navigation panel"
      within(:css, "div#navigation") { yield }
    elsif locator == "the live preview"
      within(:css, "div#editor div#preview") { yield }
    elsif locator == "the note preview"
      within(:css, "div#display-note") { yield }
    else
      locator ? within(locator) { yield } : yield
    end
  end
end
World(WithinHelpers)

When /^I wait for (\d+) minutes$/ do |arg1|
  sleep(arg1.to_i*60)
end

When /^I take a screenshot$/ do
  page.driver.save_screenshot("/tmp/foo.png")
end

When /^I wait for you$/ do
  binding.pry
end

##
# Thanks to Ben for this step
# Thanks to John Feminella for the original version of this step (http://gist.github.com/583670)
Given /^an? (.+) exists with (?:an? )?(.+) (?:of )?\"([^\"]*)\"$/ do |model, field, value|
  factory_name = model.gsub(' ', '_').to_sym
  field.gsub!(' ', '_')
  eval("@#{factory_name} = FactoryGirl.create(factory_name, field => value)")
end

Then /^I should see the (.*)$/ do |model|
  factory_name = model.gsub(' ', '_').to_sym
  object = eval("@#{factory_name}")
  step %Q{I should see "#{object.title}"}
end

Then /^I should see a link to "([^"]*)"$/ do |link_content|
  find(:xpath, "//a[contains(., '#{link_content}') or img[@alt='#{link_content}'] or @title='#{link_content}']")
end
