import { Page, Locator } from '@playwright/test';
import { BasePage } from './BasePage';

export class CartPage extends BasePage {
  readonly titleHeader: Locator;
  readonly cartItems: Locator;
  readonly checkoutButton: Locator;
  readonly continueShoppingButton: Locator;

  constructor(page: Page) {
    super(page);
    this.titleHeader = page.locator('[data-test="title"]');
    this.cartItems = page.locator('.cart_item');
    this.checkoutButton = page.locator('[data-test="checkout"]');
    this.continueShoppingButton = page.locator('[data-test="continue-shopping"]');
  }

  async proceedToCheckout(): Promise<void> {
    await this.checkoutButton.click();
  }

  async getCartItemNames(): Promise<string[]> {
    const names = await this.cartItems.locator('.inventory_item_name').allTextContents();
    return names.map(n => n.trim());
  }
}
