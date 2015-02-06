Feature: Viewing campaign details
  As a CSM or CSR wants to see a campaign details
  I should be able to click on any campaign and view its details

  Background:
    Given I am logged in as a CSM user
    When I select Campaigns from the main menu
    Then I should be on Campaigns page
    When I select a campaign to view details
    Then I should be on Campaign Details page
    And the url of the page contains the id of the campaign selected

  @AP-55
  Scenario: Viewing campaign details
    And details of above campaign are displayed


