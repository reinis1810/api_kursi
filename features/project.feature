Feature: Project feature
  Test the creation of projects

  Scenario: Positive project
    When I log in apimation.com as a regular user
    And I try to make a new project
    Then I check if the project is made

  Scenario: Project Test environment
    When I log in apimation.com as a regular user
    And I make a new Prod environment
    Then I check if the Prod environment is made

  Scenario: Project Dev environment
    When I log in apimation.com as a regular user
    And I make a new Dev environment
    Then I check if the Dev environment is made

  Scenario: Project global values
    When I log in apimation.com as a regular user
    And I add first global value
    Then I add second global value