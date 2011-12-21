Feature: Sign up

  Background:
    Given I am not logged in

  Scenario: User signs up with valid data
    When I sign up with valid user data
    Then I should see a successful sign up message

  Scenario: Users signs up with invalid email
    When I sign up with invalid email
    Then I should see  an invalid email message

  Scenario: Users signs up with

