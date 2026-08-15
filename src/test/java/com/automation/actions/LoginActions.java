package com.automation.actions;

import com.automation.pages.InventoryPage;
import com.automation.pages.LoginPage;
import net.serenitybdd.annotations.Step;

public class LoginActions {
    LoginPage loginPage;
    InventoryPage inventoryPage;

    @Step("Open the SauceDemo login page")
    public void openLoginPage() {
        loginPage.openApplication();
    }

    @Step("Login as user '{0}'")
    public void loginAs(String username, String password) {
        loginPage.loginAs(username, password);
        inventoryPage.waitUntilLoaded();
    }

    public boolean loginPageIsVisible() {
        return loginPage.isDisplayed();
    }
}
