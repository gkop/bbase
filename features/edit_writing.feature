Feature: Edit writing

  @javascript
  Scenario: Edit an existing writing
    Given I am logged in as an admin
    And a writing exists with title "Minglewood St."
    When I follow "WRITINGS"
    And I follow "Minglewood St."
    Then I should see "Minglewood St."
    When I follow "Edit"
    And I follow "Edit note"
    Then the note editor should appear
    When I fill in "sometimes I am, sometimes I ain't" for "input-box"
    Then I should see "sometimes I am, sometimes I ain't" within "the live preview"
    When I press "Continue"
    Then I should see "sometimes I am, sometimes I ain't" within "the note preview"
    And I press "Update Writing"
    Then I should see "Writing was successfully updated."
    And I should see "Minglewood St."
    And I should see "sometimes I am, sometimes I ain't"
