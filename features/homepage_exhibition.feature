Feature: Custom home page exhibition

  @one
  Scenario: Set home page exhibition
    Given I am a new, authenticated user
    And I have an exhibition named "Space"
    And I have an exhibition named "Time"
    And I go to my dashboard 
    Then I should see "Space" within "my exhibitions"
    And I should see "Time" within "my exhibitions"
    When I follow "Space" within "my exhibitions"
    Then I should see "Assign to homepage"
    When I follow "Assign to homepage"
    Then I should see "Exhibition was successfully updated."
    And I should see "This exhibition is currently assigned to the homepage"
    When I follow "All exhibitions"
    And I follow "Time"
    Then I should see "Assign to homepage"
    When I follow "Assign to homepage"
    Then I should see "Exhibition was successfully updated."
    And I should see "This exhibition is currently assigned to the homepage"
    When I follow "All exhibitions"
    And I follow "Space"
    Then I should see "Assign to homepage"
