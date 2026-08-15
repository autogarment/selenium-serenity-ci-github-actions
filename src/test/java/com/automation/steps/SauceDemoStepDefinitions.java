package com.automation.steps;

import com.automation.actions.CheckoutActions;
import com.automation.actions.LoginActions;
import com.automation.actions.NavigationActions;
import com.automation.actions.ShoppingActions;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import net.serenitybdd.annotations.Steps;

import static org.assertj.core.api.Assertions.assertThat;

public class SauceDemoStepDefinitions {

    @Steps LoginActions login;
    @Steps ShoppingActions shopping;
    @Steps CheckoutActions checkout;
    @Steps NavigationActions navigation;

    @Given("I open the SauceDemo login page")
    public void openLoginPage() {
        login.openLoginPage();
    }

    @When("I login with username {string} and password {string}")
    public void login(String username, String password) {
        login.loginAs(username, password);
    }

    @Then("I should see the Products page")
    public void verifyProductsPage() {
        assertThat(shopping.inventoryTitle()).isEqualTo("Products");
    }

    @When("I open product details for {string}")
    public void openProductDetails(String productName) {
        shopping.openProduct(productName);
        assertThat(shopping.currentProductName()).isEqualTo(productName);
    }

    @Then("I should see product {string} with price {string}")
    public void verifyProduct(String productName, String price) {
        assertThat(shopping.currentProductName()).isEqualTo(productName);
        assertThat(shopping.currentProductPrice()).isEqualTo(price);
    }

    @When("I add the current product to the cart")
    public void addCurrentProduct() {
        shopping.addCurrentProductToCart();
        assertThat(shopping.cartBadge()).isEqualTo("1");
    }

    @And("I open the shopping cart")
    public void openCart() {
        shopping.openCart();
    }

    @Then("the shopping cart should contain {string} with quantity {string} and price {string}")
    public void verifyCartLine(String name, String quantity, String price) {
        assertThat(shopping.cartItemName(name)).isEqualTo(name);
        assertThat(shopping.cartItemQuantity(name)).isEqualTo(quantity);
        assertThat(shopping.cartItemPrice(name)).isEqualTo(price);
    }

    @And("I add {string} to the cart")
    public void addProductToCart(String name) {
        shopping.addProductFromInventory(name);
        shopping.openCart();
    }

    @Then("the shopping cart should contain {string}")
    public void verifyCartContains(String name) {
        assertThat(shopping.cartItemName(name)).isEqualTo(name);
    }

    @When("I proceed to checkout")
    public void proceedToCheckout() {
        checkout.checkout();
        assertThat(checkout.title()).isEqualTo("Checkout: Your Information");
    }

    @And("I enter checkout information {string} {string} {string}")
    public void enterCheckoutInformation(String firstName, String lastName, String postalCode) {
        checkout.enterCheckoutInformation(firstName, lastName, postalCode);
    }

    @Then("I should see checkout overview for {string} with price {string}")
    public void verifyOverview(String name, String price) {
        assertThat(checkout.overviewItemName()).isEqualTo(name);
        assertThat(checkout.overviewItemPrice()).isEqualTo(price);
    }

    @When("I finish the order")
    public void finishOrder() {
        checkout.finishOrder();
    }

    @Then("I should see order complete message {string}")
    public void verifyOrderComplete(String message) {
        assertThat(checkout.completeMessage()).isEqualTo(message);
    }

    @And("I logout from SauceDemo")
    public void logoutFromInventory() {
        navigation.logout();
    }

    @When("I logout from the cart page")
    public void logoutFromCart() {
        navigation.logout();
    }

    @Then("I should see the SauceDemo login page")
    public void verifyLoginPage() {
        assertThat(login.loginPageIsVisible()).isTrue();
    }
}
