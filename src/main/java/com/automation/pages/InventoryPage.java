package com.automation.pages;

import net.serenitybdd.core.pages.PageObject;
import net.serenitybdd.core.pages.WebElementFacade;
import org.openqa.selenium.By;
import org.openqa.selenium.support.FindBy;

public class InventoryPage extends PageObject {

    @FindBy(css = "[data-test='title']")
    private WebElementFacade title;

    @FindBy(css = "[data-test='shopping-cart-badge']")
    private WebElementFacade cartBadge;

    @FindBy(css = "[data-test='shopping-cart-link']")
    private WebElementFacade cartLink;

    public void waitUntilLoaded() {
        title.waitUntilVisible();
        waitForCondition().until(driver -> driver.getCurrentUrl().contains("inventory.html"));
    }

    public String title() {
        return title.getText().trim();
    }

    public void openProduct(String productName) {
        WebElementFacade productLink = find(By.xpath(
                "//div[@data-test='inventory-item-name' and normalize-space()=" + xpathLiteral(productName) + "]"
        ));
        productLink.waitUntilClickable().click();
        waitForCondition().until(driver -> driver.getCurrentUrl().contains("inventory-item.html"));
    }

    public void addProductToCart(String productName) {
        WebElementFacade productCard = find(By.xpath(
                "//div[@data-test='inventory-item'][.//div[@data-test='inventory-item-name' and normalize-space()="
                        + xpathLiteral(productName) + "]]"
        ));
        productCard.find(By.cssSelector("button[data-test^='add-to-cart']"))
                .waitUntilClickable()
                .click();
        cartBadge.waitUntilVisible();
    }

    public String cartBadge() {
        return cartBadge.getText().trim();
    }

    public void openCart() {
        cartLink.waitUntilClickable().click();
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
