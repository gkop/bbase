Feature: Slideshow on homepage

  @one @javascript
  Scenario: Visit homepage slideshow
    Given I am a new, authenticated user
    And a homepage gallery exists with name "Homepage Gallery"
    And the gallery has the artworks "Space, Time, Cosmos"
    When I go to the homepage

    Then the slideshow should be on "Cosmos"
    When I follow "next"
    Then the slideshow should be on "Space"
    When I follow "next"
    Then the slideshow should be on "Time"
    When I follow "next"
    Then the slideshow should be on "Cosmos"
    When I follow "next"
    Then the slideshow should be on "Space"
    When I follow "previous"
    Then the slideshow should be on "Cosmos"
    When I follow "previous"
    Then the slideshow should be on "Time"
    When I follow "previous"
    Then the slideshow should be on "Space"
