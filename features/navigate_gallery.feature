Feature: Navigate gallery

  Scenario: Navigate gallery
    Given I am logged in as a user
    And I have a gallery named "Familaris"
    And the gallery has the artworks "Dixie, Samson, Wolfie"
    And I am on the page for the gallery
    And I follow "Samson"
    And I should see a link to "Next artwork: Wolfie"

    When I follow "Next artwork: Wolfie"
    Then I should see a link to "Next artwork: Dixie"

    When I follow "Next artwork: Dixie"
    Then I should see a link to "Next artwork: Samson"

    When I follow "Next artwork: Samson"
    Then I should see a link to "Next artwork: Wolfie"
