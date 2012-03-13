Feature: View gallery
  
  Scenario: Galleries index shows bylines
    Given I am logged in as a user 
    And I have a gallery named "Dogwood"
    And the gallery has the artworks "Grinch, Lorax"
    When I am on the galleries page
    Then I should see a byline by my gallery
