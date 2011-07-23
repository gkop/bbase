Then /^the note editor should appear$/ do
  page.should have_css "#editor textarea#input-box"
  When "I should see \"Here's a guide to markdown syntax:\""
end
