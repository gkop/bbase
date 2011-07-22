Feature: Custom home page exhibition

  @one
  Scenario: Set home page exhibition
    Given I am logged in as an admin
    And I have an exhibition named "Space"
    And I have an exhibition named "Time"
    And I go to my dashboard 
    Then I should see "Space" within "my exhibitions"
    And I should see "Time" within "my exhibitions"
    When I follow "Space" within "my exhibitions"
    Then I should see "Assign to homepage"
    When I follow "Assign to homepage"
    Then I should see "Gallery was successfully updated"
    And I should see "This gallery is currently assigned to the homepage"
    When I follow "All galleries"
    And I follow "Time"
    Then I should see "Assign to homepage"
    When I follow "Assign to homepage"
    Then I should see "Gallery was successfully updated"
    And I should see "This gallery is currently assigned to the homepage"
    When I follow "All galleries"
    And I follow "Space"
    Then I should see "Assign to homepage"

  @two
  Scenario: No homepage exhibition
    Given I am a new, authenticated user
    And I go to the homepage
    Then I should see "Please assign a gallery to be shown on this page"

  @three
  Scenario: Empty homepage exhibition
    Given a homepage exhibition exists with name "No artworks :("
    And I am a new, authenticated user
    And I go to the homepage
    Then I should see "assigned to this page, but is empty."


