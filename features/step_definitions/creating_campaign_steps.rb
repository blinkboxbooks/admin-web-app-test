When /^I enter campaign details$/ do
 random_number=rand(1..9999).to_s
 name="Random campaign number" +random_number
 description="Random campaign description" + random_number
 create_campaign_page.fill_in_campaign_details(name,description)
end

And(/^I set the campaign to start from today$/) do
  start_date=Time.now.strftime('%a %b %d %H:%M:%S %Z %Y')
  create_campaign_page.set_start_date_for_campaign start_date
end

And(/^I choose a credit amount for each voucher$/) do
  create_campaign_page.fill_in_credit(rand(1..10))
end

And(/^I submit campaign details by clicking Create Campaign button$/) do
 create_campaign_page.submit_form
end

Then(/^confirmation popup window is shown$/) do
 expect(create_campaign_page.confirmation_popup).to be_visible
end