module WithinHelpers
  def with_scope(locator)
    if locator == "my exhibitions"
      within(:css, "div#your-exhibitions") { yield }
    elsif locator == "the navigation panel"
      within(:css, "div#navigation") { yield }
    else
      locator ? within(locator) { yield } : yield
    end
  end
end
World(WithinHelpers)

When /^I wait for (\d+) minutes$/ do |arg1|
  sleep(arg1.to_i*60)
end

##
# Thanks to Ben for this step
# Thanks to John Feminella for the original version of this step (http://gist.github.com/583670)
Given /^an? (.+) exists with (?:an? )?(.+) (?:of )?\"([^\"]*)\"$/ do |model, field, value|
  factory_name = model.gsub(' ', '_').to_sym
  eval("@#{factory_name} = Factory.create(factory_name, field => value)")
end

