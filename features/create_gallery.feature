Feature: Create gallery

  Scenario: Create a new gallery
    Given I am logged in as a user 
    Then I should see "My dashboard"
    When I follow "New gallery"
    And I fill in "Name" with "Spark Mustard"
    And I press "Create Exhibition"
    Then I should see "Gallery was successfully created"
    Then I should see "Spark Mustard"
    When I go to my dashboard
    Then I should see "Spark Mustard"
