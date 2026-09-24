/**
 * Centralized Test Data and Fixtures for E2E Automation
 */
export const USERS = {
  standard: {
    username: 'standard_user',
    password: process.env.TEST_PASSWORD || 'secret_sauce',
  },
  locked: {
    username: 'locked_out_user',
    password: process.env.TEST_PASSWORD || 'secret_sauce',
  },
  problem: {
    username: 'problem_user',
    password: process.env.TEST_PASSWORD || 'secret_sauce',
  },
  invalid: {
    username: 'non_existent_user',
    password: 'wrong_password_123',
  },
};

export const CUSTOMER_DETAILS = {
  valid: {
    firstName: 'Yong Giovani',
    lastName: 'Edbert',
    postalCode: '94105',
  },
  missingPostal: {
    firstName: 'Yong Giovani',
    lastName: 'Edbert',
    postalCode: '',
  },
};

export const PRODUCTS = {
  backpack: 'Sauce Labs Backpack',
  bikeLight: 'Sauce Labs Bike Light',
  boltTShirt: 'Sauce Labs Bolt T-Shirt',
  fleeceJacket: 'Sauce Labs Fleece Jacket',
  onesie: 'Sauce Labs Onesie',
};

export const ERROR_MESSAGES = {
  lockedOut: 'Epic sadface: Sorry, this user has been locked out.',
  invalidCredentials: 'Epic sadface: Username and password do not match any user in this service',
  missingUsername: 'Epic sadface: Username is required',
  missingPostalCode: 'Error: Postal Code is required',
};
