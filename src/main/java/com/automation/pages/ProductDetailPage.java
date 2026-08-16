package com.automation.pages;

import net.serenitybdd.core.pages.PageObject;
import net.serenitybdd.core.pages.WebElementFacade;
import org.openqa.selenium.support.FindBy;

public class ProductDetailPage extends PageObject {

    @FindBy(css = "[data-test='inventory-item-name']")
    private WebElementFacade productName;

    @FindBy(css = "[data-test='inventory-item-price']")
    private WebElementFacade productPrice;

    @FindBy(css = "button[data-test='add-to-cart']")
    private WebElementFacade addToCartButton;

    @FindBy(css = "[data-test='shopping-cart-badge']")
    private WebElementFacade cartBadge;

    @FindBy(css = "[data-test='shopping-cart-link']")
    private WebElementFacade cartLink;

    public void waitUntilLoaded() {
        waitForCondition().until(driver -> driver.getCurrentUrl().contains("inventory-item.html"));
        productName.waitUntilVisible();
        addToCartButton.waitUntilVisible();
    }

    public String productName() {
        return productName.getText().trim();
    }

    public String productPrice() {
        return productPrice.getText().trim();
    }

    public void addCurrentProductToCart() {
        addToCartButton.waitUntilClickable().click();
        cartBadge.waitUntilVisible();
    }

    public String cartBadge() {
        return cartBadge.getText().trim();
    }

    public void openCart() {
        cartLink.waitUntilClickable().click();
    }
}
