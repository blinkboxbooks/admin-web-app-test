Feature: Create Campaign
  As a CSM or MKT wants to create a campaign
  I should be able to click on new campaign button and create one

  Background:
    Given I am signed in
    And I am on Campaigns page
    When I click on create campaign to create new campaign
    Then I should be on Create Campaign page

  @test1
  Scenario: Fill the details of campaign form without an end date and unlimited number of vouchers
    When I enter campaign details
    And I set the campaign to start from today
    And I choose a credit amount for each voucher
    And I submit campaign details by clicking Create Campaign button
    Then confirmation popup window is shown
    And all details displayed in popup window is the same as th details in form
    And I click yes in confirmation popup
    Then I see the details of the new campaign in the campaign details page
    And the newly created campaign should be on active campaigns on campaigns page

  @test2
  Scenario: Fill the details of campaign form with an end date and a specified number of vouchers
    When I enter campaign details
    And I set the campaign to start from tomorrow
    And I un-check the ongoing checkbox
    Then I set an end date to campaign
    And I choose a credit amount for each voucher
    And I un-check the unlimited checkbox
    Then I fill a redemption limit
    And I submit campaign details by clicking Create Campaign button
    Then confirmation popup window is shown
    And all details displayed in popup window is the same as th details in form
    And I click yes in confirmation popup
    Then I see the details of the new campaign in the campaign details page
    And the newly created campaign should be on pending campaigns on campaigns page



