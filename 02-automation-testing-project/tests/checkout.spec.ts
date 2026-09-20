import { test, expect } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';
import { InventoryPage } from '../pages/InventoryPage';
import { CartPage } from '../pages/CartPage';
import { CheckoutPage } from '../pages/CheckoutPage';
import { USERS, CUSTOMER_DETAILS, PRODUCTS, ERROR_MESSAGES } from '../test-data/testData';

test.describe('End-to-End Checkout Flow Suite', () => {
  let loginPage: LoginPage;
  let inventoryPage: InventoryPage;
  let cartPage: CartPage;
  let checkoutPage: CheckoutPage;

  test.beforeEach(async ({ page }) => {
    loginPage = new LoginPage(page);
    inventoryPage = new InventoryPage(page);
    cartPage = new CartPage(page);
    checkoutPage = new CheckoutPage(page);

    await loginPage.open();
    await loginPage.login(USERS.standard.username, USERS.standard.password);
  });

  test('TC-CHK-01: Complete successful checkout purchase journey', async ({ page }) => {
    // 1. Add product to cart
    await inventoryPage.addItemToCartByName(PRODUCTS.backpack);
    await inventoryPage.goToCart();

    // 2. Verify item in cart
    await expect(page).toHaveURL(/.*cart.html/);
    const cartItems = await cartPage.getCartItemNames();
    expect(cartItems).toContain(PRODUCTS.backpack);

    // 3. Proceed to checkout
    await cartPage.proceedToCheckout();
    await expect(page).toHaveURL(/.*checkout-step-one.html/);

    // 4. Fill shipping information
    await checkoutPage.fillInformation(
      CUSTOMER_DETAILS.valid.firstName,
      CUSTOMER_DETAILS.valid.lastName,
      CUSTOMER_DETAILS.valid.postalCode
    );

    // 5. Verify overview calculations
    await expect(page).toHaveURL(/.*checkout-step-two.html/);
    await expect(checkoutPage.subtotalLabel).toContainText('$29.99');
    await expect(checkoutPage.taxLabel).toContainText('$2.40');
    await expect(checkoutPage.totalLabel).toContainText('$32.39');

    // 6. Complete purchase
    await checkoutPage.completeOrder();
    await expect(page).toHaveURL(/.*checkout-complete.html/);
    const successHeader = await checkoutPage.getCompletionMessage();
    expect(successHeader).toContain('Thank you for your order!');
  });

  test('TC-CHK-02: Missing postal code triggers inline checkout validation', async ({ page }) => {
    await inventoryPage.addItemToCartByName(PRODUCTS.backpack);
    await inventoryPage.goToCart();
    await cartPage.proceedToCheckout();

    // Submit with missing postal code
    await checkoutPage.fillInformation(
      CUSTOMER_DETAILS.missingPostal.firstName,
      CUSTOMER_DETAILS.missingPostal.lastName,
      CUSTOMER_DETAILS.missingPostal.postalCode
    );

    const errorMessage = await checkoutPage.getErrorMessage();
    expect(errorMessage).toContain(ERROR_MESSAGES.missingPostalCode);
    await expect(page).toHaveURL(/.*checkout-step-one.html/);
  });
});
