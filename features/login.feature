Feature: Login

  Scenario: Login Required
    Given I am a user "Henry" with email "henry@gmail.com" and password "smiles"
    And I go to my dashboard
    Then I should see "You need to sign in or sign up before continuing."
    When I fill in "user_email" with "henry@gmail.com"
    And I fill in "user_password" with "smiles"
    And I press "Sign in"
    Then I should see "My dashboard"
