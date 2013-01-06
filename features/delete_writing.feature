Feature: Delete writing

  Scenario: Delete a writing
    Given I am logged in as an admin
    And a writing exists with title "Silly Writing"
    When I follow "WRITINGS"
    And I follow "Silly Writing"
    When I follow "Delete"
    Then I should see "Writings"
    And I should see "Deleted writing Silly Writing"
    When I follow "WRITINGS"
    Then I should not see "Silly Writing"
