import { test, expect } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';
import { InventoryPage } from '../pages/InventoryPage';
import { USERS, PRODUCTS } from '../test-data/testData';

test.describe('Product Inventory & Sorting Feature Suite', () => {
  let loginPage: LoginPage;
  let inventoryPage: InventoryPage;

  test.beforeEach(async ({ page }) => {
    loginPage = new LoginPage(page);
    inventoryPage = new InventoryPage(page);

    await loginPage.open();
    await loginPage.login(USERS.standard.username, USERS.standard.password);
    await expect(page).toHaveURL(/.*inventory.html/);
  });

  test('TC-INV-01: Verify product price sorting from Low to High', async () => {
    await inventoryPage.selectSortOption('lohi');
    const prices = await inventoryPage.getAllItemPrices();

    // Verify ascending order
    const sortedPrices = [...prices].sort((a, b) => a - b);
    expect(prices).toEqual(sortedPrices);
    expect(prices[0]).toBe(7.99); // Lowest price item
  });

  test('TC-INV-02: Verify product price sorting from High to Low', async () => {
    await inventoryPage.selectSortOption('hilo');
    const prices = await inventoryPage.getAllItemPrices();

    // Verify descending order
    const sortedPrices = [...prices].sort((a, b) => b - a);
    expect(prices).toEqual(sortedPrices);
    expect(prices[0]).toBe(49.99); // Highest price item
  });

  test('TC-INV-03: Verify product alphabetical sorting Z to A', async () => {
    await inventoryPage.selectSortOption('za');
    const titles = await inventoryPage.getAllItemTitles();

    const sortedTitles = [...titles].sort().reverse();
    expect(titles).toEqual(sortedTitles);
  });

  test('TC-INV-04: Add and remove items from cart updates cart badge dynamically', async () => {
    // Initial cart should be empty
    expect(await inventoryPage.getCartCount()).toBe(0);

    // Add backpack
    await inventoryPage.addItemToCartByName(PRODUCTS.backpack);
    expect(await inventoryPage.getCartCount()).toBe(1);

    // Add bike light
    await inventoryPage.addItemToCartByName(PRODUCTS.bikeLight);
    expect(await inventoryPage.getCartCount()).toBe(2);

    // Remove backpack
    await inventoryPage.removeItemFromCartByName(PRODUCTS.backpack);
    expect(await inventoryPage.getCartCount()).toBe(1);
  });
});
