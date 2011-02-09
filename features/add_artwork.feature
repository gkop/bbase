Feature: Add artwork

  Scenario: Add a new artwork
    Given I am a new, authenticated user  
    Then I should see "My dashboard"
    When I follow "New artwork"
    And I fill in "Title" with "Ring Nebula"
    And I fill in "Year" with "1977"
    And I attach the file "spec/data/ring_nebula_1987.jpg" to "artwork_image"
    And I press "Create Artwork"
    Then I should see "Artwork was successfully created."
    Then I should see "Ring Nebula (1977)"
