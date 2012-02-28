Feature: Tagged artwork

  Scenario:  Paintings
    Given a painting exists with title "I'm a painting"
    And I am a new, authenticated user
    And I am on the Paintings page.
    Then I should see "Paintings"
    And I should see the painting 
  
  Scenario:  Prints
    Given a print exists with title "I'm a print"
    And I am a new, authenticated user
    And I am on the Prints page.
    Then I should see "Prints"
    And I should see the print
  
  Scenario:  Sculptures
    Given a sculpture exists with title "I'm a sculpture"
    And I am a new, authenticated user
    And I am on the Sculptures page.
    Then I should see "Sculptures"
    And I should see the sculpture
