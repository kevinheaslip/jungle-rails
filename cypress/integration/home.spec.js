/* eslint-disable no-undef */
describe('Home', () => {
  beforeEach(() => {
    cy.visit('/');
  });
  
  it('Loads the home page', () => {
    cy.visit('/');
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });  
});
