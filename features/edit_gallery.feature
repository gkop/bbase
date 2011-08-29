Feature: Edit gallery
  
  @one
  Scenario: Change galley name
    Given I am logged in as a user 
    And I have a gallery named "Dogwood"
    And I am on the page for the gallery
    Then I should see "Dogwood"
    When I follow "Edit"
    And I fill in "Gladiator" for "Name"
    And I press "Update Exhibition"
    Then I should see "Gallery was successfully updated"
    And I should see "Gladiator"

  @two
  @javascript
  Scenario: Add note for gallery
    Given I am logged in as a user 
    And I have a gallery named "Huron"
    And I am on the page for the gallery
    When I follow "Edit"
    And I follow "Edit note"
    Then the note editor should appear
    When I fill in "new note for an old gallery" for "input-box"
    Then I should see "new note for an old gallery" within "the live preview"
    When I press "Continue"
    Then I should see "new note for an old gallery" within "the note preview"
    When I press "Update Exhibition"
    Then I should see "Gallery was successfully updated"
    And I should see "new note for an old gallery"

  @three
  Scenario: Mark and unmark gallery as curated
    Given I am logged in as an admin
    And an exhibition exists with name "To be blessed"
    And I am on the page for the gallery
    When I follow "Edit"
    And I check "Curated"
    And I press "Update Exhibition"
    Then I should see "Gallery was successfully updated"
    And I should see "This gallery is officially curated by a Golahny expert"
    When I follow "Edit"
    And I uncheck "Curated"
    And I press "Update Exhibition"
    Then I should see "Gallery was successfully updated"
    And I should not see "This gallery is officially curated by a Golahny expert"

