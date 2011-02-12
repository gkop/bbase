Feature: Slideshow on homepage

  @one @javascript
  Scenario: Visit homepage slideshow
    Given I am a new, authenticated user
    And a homepage exhibition exists with name "Homepage Exhibition"
    And the exhibition has the artworks "Space, Time, Cosmos"
    When I go to the homepage
    Then I should see "Space"
    When I follow "next"
    Then I should see "Time"
    When I follow "next"
    Then I should see "Cosmos"
    When I follow "next"
    Then I should see "Space"
    When I follow "previous"
    Then I should see "Cosmos"
    When I follow "previous"
    Then I should see "Time"
    When I follow "previous"
    Then I should see "Space"
