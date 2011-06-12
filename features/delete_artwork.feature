Feature: Delete artwork

  Scenario: Delete an existing artwork
    Given an artwork exists with title "Coral"
    And I am logged in as an admin 
    When I follow "Coral"
    And I follow "Delete" within "the navigation panel"
    Then I should see "All artworks"
    And I should see "Deleted artwork Coral"
    When I go to my dashboard
    Then I should not see "Coral"
