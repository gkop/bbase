Feature: Edit artwork

  @one
  Scenario: Change artwork year
    Given I am logged in as an admin
    And an artwork exists with numeric year "1993"
    And I am on the page for the artwork
    Then I should see "1993"
    When I follow "Edit"
    And I fill in "1994" for "Numeric year"
    And I press "Update Artwork"
    Then I should see "Artwork was successfully updated"
    And I should see "1994"

  @two
  @javascript
  Scenario: Add note for artwork
    Given I am logged in as an admin
    And an artwork exists with title "Notorious"
    And I am on the page for the artwork
    When I follow "Edit"
    And I follow "Edit note"
    Then the note editor should appear
    When I fill in "hello world" for "input-box"
    Then I should see "hello world" within "the live preview"
    When I press "Continue"
    Then I should see "hello world" within "the note preview"
    When I press "Update Artwork"
    Then I should see "Artwork was successfully updated"
    And I should see "hello world"
