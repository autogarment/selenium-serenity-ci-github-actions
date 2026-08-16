package com.automation.pages;

import net.serenitybdd.core.pages.PageObject;
import net.serenitybdd.core.pages.WebElementFacade;
import org.openqa.selenium.support.FindBy;

public class CheckoutPage extends PageObject {

    @FindBy(css = "[data-test='title']")
    private WebElementFacade title;

    @FindBy(css = "[data-test='firstName']")
    private WebElementFacade firstName;

    @FindBy(css = "[data-test='lastName']")
    private WebElementFacade lastName;

    @FindBy(css = "[data-test='postalCode']")
    private WebElementFacade postalCode;

    @FindBy(css = "[data-test='continue']")
    private WebElementFacade continueButton;

    @FindBy(css = "[data-test='inventory-item-name']")
    private WebElementFacade overviewItemName;

    @FindBy(css = "[data-test='inventory-item-price']")
    private WebElementFacade overviewItemPrice;

    @FindBy(css = "[data-test='finish']")
    private WebElementFacade finishButton;

    @FindBy(css = "[data-test='complete-header']")
    private WebElementFacade completeHeader;

    public void waitUntilInformationPageLoaded() {
        title.waitUntilVisible();
        waitForCondition().until(driver -> driver.getCurrentUrl().contains("checkout-step-one.html"));
    }

    public String title() {
        return title.getText().trim();
    }

    public void enterInformation(String first, String last, String zip) {
        firstName.waitUntilEnabled().type(first);
        lastName.waitUntilEnabled().type(last);
        postalCode.waitUntilEnabled().type(zip);
        continueButton.waitUntilClickable().click();
        overviewItemName.waitUntilVisible();
    }

    public String overviewItemName() {
        return overviewItemName.getText().trim();
    }

    public String overviewItemPrice() {
        return overviewItemPrice.getText().trim();
    }

    public void finishOrder() {
        finishButton.waitUntilClickable().click();
        completeHeader.waitUntilVisible();
    }

    public String completeMessage() {
        return completeHeader.getText().trim();
    }
}
