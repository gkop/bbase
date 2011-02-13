Feature: Delete artwork

  Scenario: Delete an existing artwork
    Given an artwork exists with title "Coral"
    And I am a new, authenticated user  
    When I follow "Coral"
    And I follow "Delete" within "the navigation panel"
    Then I should see "Listing all artworks"
    And I should see "Deleted artwork Coral"
    When I go to my dashboard
    Then I should not see "Coral"
