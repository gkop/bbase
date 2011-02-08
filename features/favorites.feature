Feature: Favorites exhibition

  @one
  Scenario: New user has empty Favorites
    Given I am a new, authenticated user 
    Then I should see "Favorites" within "my exhibitions"
    And I should see "-empty-" within "my exhibitions"

  @two
  Scenario: Add an artwork to Favorites
    Given an artwork exists with title "Stewball"
    And I am a new, authenticated user
    And I follow "Stewball"
    And I press "Favorites" within "the navigation panel"
    Then I should see "Added Stewball to Favorites"

    When I go to my dashboard
    And I follow "Favorites"
    And I follow "Stewball"
    Then I should see "Already exists in Favorites" within "the navigation panel"
