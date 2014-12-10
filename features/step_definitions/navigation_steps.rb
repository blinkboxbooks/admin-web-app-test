When /^I select (.*?) from the main menu$/ do |tab_name|
  current_page.wait_until_header_visible(10)
  current_page.header.menu.select(tab_name)
end

Then /^I should be on (.*?) page$/ do |page_name|
 #expect(page_model(page_name).displayed?).to become_true
 expect_page_displayed(page_name)
end

When(/^I select (.*?) button in filter bar$/) do |filter|
  campaigns_details_page.filter_based_on(filter)
end

Then(/^all campaigns displayed should be (.*?)$/) do |status|
  campaigns_details_page.check_enabled_status(status)
end

And(/^each campaign start date and end date is in the (.*?) and (.*?) respectively$/) do | value1, value2|
  check_start_date_and_end_date( value1, value2)
end

And(/^each campaign (.*?) is in the (.*?)$/) do |date, dateBelongsTo|
  check_date(date, dateBelongsTo)
end


And(/^I should select (.*?) option to display all entries$/) do |num|
  campaigns_details_page.display_entries(num)
end

And(/^The attributes of campaigns in the header of table are shown$/) do

end