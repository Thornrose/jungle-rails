/// <reference types="cypress" />

describe('Home page', () => {
  it('should visit root', () => {
    cy.visit('/');
  });

  it("There are 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it('should add a product to the cart', () => {
    cy.contains("My Cart (0)").should("exist");
    cy.contains("Add").first().click({ force: true });
    cy.contains("My Cart (0)").should("not.exist");
  })

})