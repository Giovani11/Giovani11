import { test, expect } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';
import { InventoryPage } from '../pages/InventoryPage';
import { USERS, ERROR_MESSAGES } from '../test-data/testData';

test.describe('Authentication Feature Suite', () => {
  let loginPage: LoginPage;
  let inventoryPage: InventoryPage;

  test.beforeEach(async ({ page }) => {
    loginPage = new LoginPage(page);
    inventoryPage = new InventoryPage(page);
    await loginPage.open();
  });

  test('TC-AUTH-01: Standard user should log in successfully and redirect to inventory', async ({ page }) => {
    await loginPage.login(USERS.standard.username, USERS.standard.password);

    await expect(page).toHaveURL(/.*inventory.html/);
    await expect(inventoryPage.titleHeader).toHaveText('Products');
    await expect(inventoryPage.inventoryItems).toHaveCount(6);
  });

  test('TC-AUTH-02: Locked out user should be denied access with proper error toast', async () => {
    await loginPage.login(USERS.locked.username, USERS.locked.password);

    const errorMessage = await loginPage.getErrorMessageText();
    expect(errorMessage).toContain(ERROR_MESSAGES.lockedOut);
  });

  test('TC-AUTH-03: Invalid credentials should display error message', async () => {
    await loginPage.login(USERS.invalid.username, USERS.invalid.password);

    const errorMessage = await loginPage.getErrorMessageText();
    expect(errorMessage).toContain(ERROR_MESSAGES.invalidCredentials);
  });

  test('TC-AUTH-04: Empty username submission should trigger required field validation', async () => {
    await loginPage.login('', 'any_password');

    const errorMessage = await loginPage.getErrorMessageText();
    expect(errorMessage).toContain(ERROR_MESSAGES.missingUsername);
  });
});
