import { Page, Locator, expect } from '@playwright/test';

/**
 * BasePage serves as the parent class for all page objects,
 * encapsulating common interactions, assertions, and utilities.
 */
export abstract class BasePage {
  readonly page: Page;

  constructor(page: Page) {
    this.page = page;
  }

  /**
   * Navigate to a relative or absolute URL path
   */
  async navigate(path: string = '/'): Promise<void> {
    await this.page.goto(path, { waitUntil: 'domcontentloaded' });
  }

  /**
   * Get the current browser URL
   */
  getUrl(): string {
    return this.page.url();
  }

  /**
   * Wait for an element and verify its visibility
   */
  async waitForElementVisible(locator: Locator, timeoutMs: number = 5000): Promise<void> {
    await expect(locator).toBeVisible({ timeout: timeoutMs });
  }

  /**
   * Take a full page screenshot
   */
  async takeScreenshot(name: string): Promise<void> {
    await this.page.screenshot({ path: `screenshots/${name}.png`, fullPage: true });
  }
}
