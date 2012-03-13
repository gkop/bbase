Feature: View user
  
  Scenario: User page does not show bylines
    Given a gallery exists with name "Dogwood"
    And the gallery has the artworks "Grinch, Lorax"
    When I am on the user page of the gallery owner
    Then I should not see a byline by the gallery
