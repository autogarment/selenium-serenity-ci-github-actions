package com.automation.pages;

import net.serenitybdd.core.pages.PageObject;
import net.serenitybdd.core.pages.WebElementFacade;
import org.openqa.selenium.support.FindBy;

public class LoginPage extends PageObject {

    @FindBy(css = "[data-test='username']")
    private WebElementFacade username;

    @FindBy(css = "[data-test='password']")
    private WebElementFacade password;

    @FindBy(css = "[data-test='login-button']")
    private WebElementFacade loginButton;

    public void openApplication() {
        openUrl(System.getProperty("webdriver.base.url", "https://www.saucedemo.com"));
        loginButton.waitUntilVisible();
    }

    public void loginAs(String user, String secret) {
        username.waitUntilEnabled().type(user);
        password.waitUntilEnabled().type(secret);
        loginButton.waitUntilClickable().click();
    }

    public boolean isDisplayed() {
        return loginButton.isCurrentlyVisible();
    }
}
