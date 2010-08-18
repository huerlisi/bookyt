Given /^the following days:$/ do |days|
  Day.create!(days.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) day$/ do |pos|
  visit days_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following days:$/ do |expected_days_table|
  expected_days_table.diff!(tableish('table tr', 'td,th'))
end

Before do
  Day.delete_all
end
