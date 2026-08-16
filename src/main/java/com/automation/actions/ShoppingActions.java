package com.automation.actions;

import com.automation.pages.CartPage;
import com.automation.pages.InventoryPage;
import com.automation.pages.ProductDetailPage;
import net.serenitybdd.annotations.Step;

public class ShoppingActions {
    InventoryPage inventoryPage;
    ProductDetailPage productDetailPage;
    CartPage cartPage;

    @Step("Open product details for '{0}'")
    public void openProduct(String productName) {
        inventoryPage.openProduct(productName);
        productDetailPage.waitUntilLoaded();
    }

    @Step("Add the current product to the cart")
    public void addCurrentProductToCart() {
        productDetailPage.addCurrentProductToCart();
    }

    @Step("Add '{0}' to the cart from inventory")
    public void addProductFromInventory(String productName) {
        inventoryPage.addProductToCart(productName);
    }

    @Step("Open the shopping cart")
    public void openCart() {
        if (getDriver().getCurrentUrl().contains("inventory-item.html")) {
            productDetailPage.openCart();
        } else {
            inventoryPage.openCart();
        }
        cartPage.waitUntilLoaded();
    }

    private org.openqa.selenium.WebDriver getDriver() {
        return inventoryPage.getDriver();
    }

    public String inventoryTitle() { return inventoryPage.title(); }
    public String currentProductName() { return productDetailPage.productName(); }
    public String currentProductPrice() { return productDetailPage.productPrice(); }
    public String cartBadge() {
        return getDriver().getCurrentUrl().contains("inventory-item.html")
                ? productDetailPage.cartBadge()
                : inventoryPage.cartBadge();
    }
    public String cartItemName(String productName) { return cartPage.itemName(productName); }
    public String cartItemPrice(String productName) { return cartPage.itemPrice(productName); }
    public String cartItemQuantity(String productName) { return cartPage.itemQuantity(productName); }
}
