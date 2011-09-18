Feature: Edit settings
 
  @javascript 
  Scenario: Change biography content
    Given I am logged in as an admin 
    And I am on the edit settings page
    When I follow "Edit biography"
    Then the note editor should appear
    When I fill in "how it all began" for "input-box"
    Then I should see "how it all began" within "the live preview"
    When I press "Continue"
    Then I should see "how it all began" within "the note preview"
    When I press "Update Settings"
    Then I should see "Successfully updated settings"
    And I should see "how it all began"
    When I go to the biography page
    And I should see "how it all began"
