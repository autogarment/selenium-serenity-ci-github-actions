@all
Feature: SauceDemo shopping capability
  As a buyer
  I want the main shopping flows to be automated
  So that the application can be released with confidence

  @video @smoke @TC001
  Scenario: TC001 - Login, view product, add to cart and logout
    Given I open the SauceDemo login page
    When I login with username "standard_user" and password "secret_sauce"
    Then I should see the Products page
    When I open product details for "Sauce Labs Backpack"
    Then I should see product "Sauce Labs Backpack" with price "$29.99"
    When I add the current product to the cart
    And I open the shopping cart
    Then the shopping cart should contain "Sauce Labs Backpack" with quantity "1" and price "$29.99"
    When I logout from the cart page
    Then I should see the SauceDemo login page

  @smoke @TC002
  Scenario: TC002 - Login with valid credentials
    Given I open the SauceDemo login page
    When I login with username "standard_user" and password "secret_sauce"
    Then I should see the Products page

  @regression @TC003
  Scenario: TC003 - Add Sauce Labs Backpack to shopping cart
    Given I open the SauceDemo login page
    When I login with username "standard_user" and password "secret_sauce"
    And I open product details for "Sauce Labs Backpack"
    And I add the current product to the cart
    And I open the shopping cart
    Then the shopping cart should contain "Sauce Labs Backpack" with quantity "1" and price "$29.99"

  @regression @TC004
  Scenario: TC004 - Checkout one product successfully
    Given I open the SauceDemo login page
    When I login with username "standard_user" and password "secret_sauce"
    And I add "Sauce Labs Backpack" to the cart
    Then the shopping cart should contain "Sauce Labs Backpack"
    When I proceed to checkout
    And I enter checkout information "Tung" "Lai" "100000"
    Then I should see checkout overview for "Sauce Labs Backpack" with price "$29.99"
    When I finish the order
    Then I should see order complete message "Thank you for your order!"

  @smoke @TC005
  Scenario: TC005 - Logout from SauceDemo
    Given I open the SauceDemo login page
    When I login with username "standard_user" and password "secret_sauce"
    And I logout from SauceDemo
    Then I should see the SauceDemo login page
