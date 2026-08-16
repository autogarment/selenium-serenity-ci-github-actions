package com.automation.pages;

import net.serenitybdd.core.pages.PageObject;
import net.serenitybdd.core.pages.WebElementFacade;
import org.openqa.selenium.support.FindBy;

public class MenuComponent extends PageObject {

    @FindBy(id = "react-burger-menu-btn")
    private WebElementFacade menuButton;

    @FindBy(id = "logout_sidebar_link")
    private WebElementFacade logoutLink;

    public void logout() {
        menuButton
                .withTimeoutOf(java.time.Duration.ofSeconds(10))
                .waitUntilClickable()
                .click();

        logoutLink
                .withTimeoutOf(java.time.Duration.ofSeconds(10))
                .waitUntilVisible()
                .waitUntilClickable()
                .click();

        waitForCondition()
                .until(driver -> driver.getCurrentUrl().matches(".*/?$"));
    }
}