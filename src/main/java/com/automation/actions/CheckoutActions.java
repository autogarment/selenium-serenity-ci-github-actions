package com.automation.actions;

import com.automation.pages.CartPage;
import com.automation.pages.CheckoutPage;
import net.serenitybdd.annotations.Step;

public class CheckoutActions {
    CartPage cartPage;
    CheckoutPage checkoutPage;

    @Step("Proceed to checkout")
    public void checkout() {
        cartPage.checkout();
        checkoutPage.waitUntilInformationPageLoaded();
    }

    @Step("Enter checkout information for '{0} {1}'")
    public void enterCheckoutInformation(String firstName, String lastName, String postalCode) {
        checkoutPage.enterInformation(firstName, lastName, postalCode);
    }

    @Step("Finish the order")
    public void finishOrder() {
        checkoutPage.finishOrder();
    }

    public String title() { return checkoutPage.title(); }
    public String overviewItemName() { return checkoutPage.overviewItemName(); }
    public String overviewItemPrice() { return checkoutPage.overviewItemPrice(); }
    public String completeMessage() { return checkoutPage.completeMessage(); }
}
