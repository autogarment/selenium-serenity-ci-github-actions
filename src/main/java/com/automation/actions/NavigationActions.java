package com.automation.actions;

import com.automation.pages.LoginPage;
import com.automation.pages.MenuComponent;
import net.serenitybdd.annotations.Step;

public class NavigationActions {
    MenuComponent menu;
    LoginPage loginPage;

    @Step("Logout from SauceDemo")
    public void logout() {
        menu.logout();
        loginPage.isDisplayed();
    }
}
