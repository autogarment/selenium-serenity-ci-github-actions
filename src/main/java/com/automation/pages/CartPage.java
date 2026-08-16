package com.automation.pages;

import net.serenitybdd.core.pages.PageObject;
import net.serenitybdd.core.pages.WebElementFacade;
import org.openqa.selenium.By;
import org.openqa.selenium.support.FindBy;

public class CartPage extends PageObject {

    @FindBy(css = "[data-test='title']")
    private WebElementFacade title;

    @FindBy(css = "[data-test='checkout']")
    private WebElementFacade checkoutButton;

    public void waitUntilLoaded() {
        title.waitUntilVisible();
        waitForCondition().until(driver -> driver.getCurrentUrl().contains("cart.html"));
    }

    public String title() {
        return title.getText().trim();
    }

    public String itemName(String expectedProductName) {
        return cartItem(expectedProductName)
                .find(By.cssSelector("[data-test='inventory-item-name']"))
                .getText().trim();
    }

    public String itemPrice(String expectedProductName) {
        return cartItem(expectedProductName)
                .find(By.cssSelector("[data-test='inventory-item-price']"))
                .getText().trim();
    }

    public String itemQuantity(String expectedProductName) {
        return cartItem(expectedProductName)
                .find(By.cssSelector("[data-test='item-quantity']"))
                .getText().trim();
    }

    public void checkout() {
        checkoutButton.waitUntilClickable().click();
    }

    private WebElementFacade cartItem(String productName) {
        WebElementFacade item = find(By.xpath(
                "//div[@data-test='inventory-item'][.//div[@data-test='inventory-item-name' and normalize-space()="
                        + xpathLiteral(productName) + "]]"
        ));
        item.waitUntilVisible();
        return item;
    }

    private static String xpathLiteral(String value) {
        if (!value.contains("'")) {
            return "'" + value + "'";
        }
        if (!value.contains("\"")) {
            return "\"" + value + "\"";
        }
        return "concat('" + value.replace("'", "',\"'\",'") + "')";
    }
}
