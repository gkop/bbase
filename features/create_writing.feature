Feature: Create writing

  @javascript
  Scenario: Create a new writing
    Given I am logged in as an admin
    When I follow "WRITINGS"
    And I follow "New writing"
    Then I should see "New Writing"
    And I fill in "Title" with "Poem about cheese"
    And I fill in "Asset filename" with "rails.png"
    And I follow "Edit note"
    Then the note editor should appear
    When I fill in "mozzarella haiku" for "input-box"
    Then I should see "mozzarella haiku" within "the live preview"
    When I press "Continue"
    Then I should see "mozzarella haiku" within "the note preview"
    And I press "Create Writing"
    Then I should see "Writing was successfully created"
    And I should see "Poem about cheese"
    And I should see "mozzarella haiku"
