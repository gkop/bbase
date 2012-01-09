Then /^the note editor should appear$/ do
  page.should have_css "#editor textarea#input-box"
  step %Q{I should see "Here's a guide to markdown syntax:"}
end
