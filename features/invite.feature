Feature: Invite an email address
 
  @one 
  Scenario: Invite an email address
    Given I am logged in as a user
    And I follow "invite somebody"
    And I fill in "invite_recipient@test.golahny.org" for "Email"
    And I press "Send an invitation"

    Then I should see "An invitation email has been sent to invite_recipient@test.golahny.org." 
    When I follow "Logout"   
 
    And "invite_recipient@test.golahny.org" should have 1 email

    When I open the email
    Then I should see "Invitation instructions, Golahny.org" in the email subject
    And I should see "To accept the invitation, please click the link below." in the email body
   
    When I follow "Accept invitation" in the email
    Then I should see "Set your name and password"

    When I fill in "Clifford" for "Name"
    And I fill in "bigreddog" for "Password"
    And I fill in "bigreddog" for "Password confirmation"
    And I press "Accept invitation"

    Then I should see "Your name and password were set successfully. You are now signed in."
    And I should see "My dashboard"
