Feature: Viewing all campaigns
  As a CSM or CSR wants to see all campaigns
  I should be able to view all active, pending and expired campaigns (AP-42)

  Background:
    Given I am logged in as a CSM user
    When I select Campaigns from the main menu
    Then I should be on Campaigns Details page
    And I should select All option to display all entries
    And The attributes of campaigns in the header of table are shown

  @excluded
  Scenario: Viewing all details of campaign
    When I select a campaign to view details
    And details of above campaign are displayed

  @AP-42
  Scenario: Viewing all active campaigns
    When I select Active button in filter bar
    Then all campaigns displayed should be enabled
    And  each campaign start date and end date is in the past and future respectively

  @AP-42
  Scenario: Viewing all pending campaigns
    When I select Pending button in filter bar
    Then all campaigns displayed should be enabled
    And  each campaign start date is in the future

  @AP-42
  Scenario: Viewing all expired campaigns
    When I select Expired button in filter bar
    And  each campaign end date is in the past

  @AP-42
  Scenario: Viewing all disabled campaigns
    When I select Disabled button in filter bar
    Then all campaigns displayed should be disabled



