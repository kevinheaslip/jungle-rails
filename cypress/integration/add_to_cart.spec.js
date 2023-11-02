/* eslint-disable no-undef */
describe('Add to cart', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it('Adds a product to cart and increases cart count by 1 when the button is clicked', () => {
    cy.contains('My Cart (0)');
    cy.contains('Add').first().click({ force: true });
    cy.contains('My Cart (1)');
  });
});
