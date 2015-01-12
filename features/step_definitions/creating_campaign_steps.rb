When /^I enter campaign details$/ do
 random_number=rand(1..9999).to_s
 @name="Random campaign number" +random_number
 @description="Random campaign description" + random_number
 create_campaign_page.fill_in_campaign_details(@name,@description)
end

And(/^I set the campaign to start from (.*?)$/) do |date|
  if date == 'today'
    @start_date = format_date_to_utc Time.now
  else
    @start_date = format_date_to_utc tomorrow_date
  end
  expect(create_campaign_page.is_start_date_popup_visible).to be_truthy
  create_campaign_page.set_start_date_for_campaign @start_date
end

And(/^I un-check the (.*?) checkbox$/)do |type|
  if(type == 'ongoing')
    create_campaign_page.campaign_start_date.ongoing_checkbox.set false if create_campaign_page.campaign_start_date.ongoing_is_enable?
  else
    create_campaign_page.redemption_limit.checkbox.set false if create_campaign_page.redemption_limit.unlimited_is_enable?
  end
end

And(/^I set an end date to campaign$/)do
  @end_date = generate_random_future_date
  create_campaign_page.set_end_date_for_campaign @end_date
end

And(/^I choose a credit amount for each voucher$/) do
  @credit=rand(1..10)
  create_campaign_page.fill_in_credit(@credit)
end

And(/^I fill a redemption limit$/) do
  @redemption_limit=rand(100..200)
  create_campaign_page.set_redemption_limit(@redemption_limit)
end

And(/^I submit campaign details by clicking Create Campaign button$/) do
 create_campaign_page.submit_form
end

Then(/^confirmation popup window is shown$/) do
 expect(create_campaign_page.confirmation_popup).to be_visible
end

And(/^all details displayed in popup window is the same as th details in form$/) do
  popup_details= create_campaign_page.confirmation_popup.list_of_elements
   expect(create_campaign_list_of_elements(@name,@description,@credit.to_s,@redemption_limit,@start_date,@end_date)).to match_array(popup_details)
end

And(/^I click yes in confirmation popup$/) do
  create_campaign_page.confirmation_popup.confirm_campaign
end

Then(/^I see the details of the new campaign in the campaign details page$/) do
  assert_page('Campaign Details')
  expect(campaign_details_page.list_is_full).to be_truthy
  @creation_id=campaign_details_page.campaign_details_list.campaign_ID.text
end

And(/^the newly created campaign should be on (.*?) campaigns on campaigns page$/) do |filter|
  campaigns_page.load
  campaigns_page.filter_based_on(filter)
  campaigns_page.display_entries('All')
  campaigns_page_id=campaigns_page.table.rows.last.columns[0].text
  expect(@creation_id).to eq(campaigns_page_id)
end
