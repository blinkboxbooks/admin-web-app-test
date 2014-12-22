When /^I enter campaign details$/ do
 random_number=rand(1..9999).to_s
 @name="Random campaign number" +random_number
 @description="Random campaign description" + random_number
 create_campaign_page.fill_in_campaign_details(@name,@description)
end

And(/^I set the campaign to start from today$/) do
  @start_date=Time.now.strftime('%a %b %d %H:%M:%S %Z %Y')
  create_campaign_page.set_start_date_for_campaign @start_date
end

And(/^I choose a credit amount for each voucher$/) do
  @credit=rand(1..10)
  create_campaign_page.fill_in_credit(@credit)
end

And(/^I submit campaign details by clicking Create Campaign button$/) do
 create_campaign_page.submit_form
end

Then(/^confirmation popup window is shown$/) do
 expect(create_campaign_page.confirmation_popup).to be_visible
end

And(/^all details displayed in popup window is the same as th details in form$/) do
  popup_details= create_campaign_page.confirmation_popup.list_of_elements
  expect(create_campaign_list_of_elements(@name,@description,@credit.to_s,'',@start_date,'')).to match_array(popup_details)
end

And(/^I click yes in confirmation popup$/) do
  create_campaign_page.confirmation_popup.confirm_campaign
end

Then(/^I see the details of the new campaign in the campaign details page$/) do
  expect(!campaign_details_page.list_is_empty).to be_truthy
end
