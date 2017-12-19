Feature: Login feature
  Test the login functionality of apimation.com

  Scenario: Positive login
    When I log in apimation.com as a regular user
    Then I check if I am logged in and can access my personal information


  Scenario: Negative login
    When I try to log in appimation.com with a wrong password
    Then I check if I am not logged in and I cannot access my personal data