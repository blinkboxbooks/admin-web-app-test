Feature: Viewing all campaigns
  As a CSM or CSR wants to see all campaigns
  I should be able to view all active, pending and expired campaigns (AP-42)

  Background:
    Given I am signed in

  @AP-42
  Scenario: Viewing all campaigns
    When I select All button in filter bar
    And The attributes of campaigns in the header of table are shown
    Then  the number of campaign entries is equal with the number displayed

  @AP-42
  Scenario: Viewing all active and pending campaigns
    When I select Active button in filter bar
    Then all campaigns displayed should be enabled
    And each campaign start date and end date is in the past and future respectively
    When I select Pending button in filter bar
    Then all campaigns displayed should be enabled
    And each campaign start date is in the future

  @AP-42
  Scenario: Viewing all expired and disabled campaigns
    When I select Expired button in filter bar
    And each campaign end date is in the past
    When I select Disabled button in filter bar
    Then all campaigns displayed should be disabled

  @AP-42
  Scenario: Viewing all details of campaign
    When I select a campaign to view details
    Then I should be on Campaign Details page

