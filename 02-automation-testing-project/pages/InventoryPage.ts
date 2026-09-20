import { Page, Locator } from '@playwright/test';
import { BasePage } from './BasePage';

export class InventoryPage extends BasePage {
  readonly titleHeader: Locator;
  readonly inventoryItems: Locator;
  readonly sortSelect: Locator;
  readonly shoppingCartBadge: Locator;
  readonly shoppingCartLink: Locator;

  constructor(page: Page) {
    super(page);
    this.titleHeader = page.locator('[data-test="title"]');
    this.inventoryItems = page.locator('.inventory_item');
    this.sortSelect = page.locator('[data-test="product-sort-container"]');
    this.shoppingCartBadge = page.locator('[data-test="shopping-cart-badge"]');
    this.shoppingCartLink = page.locator('[data-test="shopping-cart-link"]');
  }

  async addItemToCartByName(productName: string): Promise<void> {
    const itemCard = this.inventoryItems.filter({ hasText: productName });
    await itemCard.locator('button:has-text("Add to cart")').click();
  }

  async removeItemFromCartByName(productName: string): Promise<void> {
    const itemCard = this.inventoryItems.filter({ hasText: productName });
    await itemCard.locator('button:has-text("Remove")').click();
  }

  async getCartCount(): Promise<number> {
    if (await this.shoppingCartBadge.isVisible()) {
      const text = await this.shoppingCartBadge.textContent();
      return text ? parseInt(text, 10) : 0;
    }
    return 0;
  }

  async selectSortOption(value: 'az' | 'za' | 'lohi' | 'hilo'): Promise<void> {
    await this.sortSelect.selectOption(value);
  }

  async getAllItemPrices(): Promise<number[]> {
    const priceLocators = await this.page.locator('.inventory_item_price').all();
    const prices: number[] = [];
    for (const locator of priceLocators) {
      const text = await locator.textContent();
      if (text) {
        prices.push(parseFloat(text.replace('$', '')));
      }
    }
    return prices;
  }

  async getAllItemTitles(): Promise<string[]> {
    const titleLocators = await this.page.locator('.inventory_item_name').all();
    const titles: string[] = [];
    for (const locator of titleLocators) {
      const text = await locator.textContent();
      if (text) titles.push(text.trim());
    }
    return titles;
  }

  async goToCart(): Promise<void> {
    await this.shoppingCartLink.click();
  }
}
