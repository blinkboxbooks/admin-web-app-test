Feature: User adding sample to Library
  As a blinkbox books CSR or a CSM
  I should be able to view Customer's voucher redemption history (AP-31).
  I should also be able to to see if a voucher code has been already redeemed

  @AP-31
  Scenario Outline: Viewing customer's voucher redemption history
    Given I am logged in as a <CS>
    When I look up  a customer who has redeemed a voucher
    Then I see the new voucher history section
    And it shows the if the customer has redeemed any voucher codes

  Examples:
    |CS   |account access                 |
    |CSR  |Customer Service Representative|
    |CSM  |Customer Service Manager       |

  @AP-32
  Scenario: Viewing if a voucher code has been redeemed
    #Given I am logged in as a CSM
    And I am on the Voucher query tab
    When I search for a valid voucher code
    Then I see the voucher code & it's associated campaign details
