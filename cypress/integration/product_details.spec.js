/* eslint-disable no-undef */
describe('Product details', () => {
  beforeEach(() => {
    cy.visit('/');
  });
  
  it('Loads a product details page by clicking on a product', () => {
    cy.get('.products article').first().click();
    cy.url().should('include', '/products/13')
  });
});
