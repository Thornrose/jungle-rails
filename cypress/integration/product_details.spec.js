/// <reference types="cypress" />

describe('Product details', () => {
  it('should visit root', () => {
    cy.visit('/');
  });

  it('There are 2 products on the page', () => {
    cy.get('.products article').should('have.length', 2);
  });

  it('should navigate to product details', () => {
    cy.get('[alt="Scented Blade"]').click();
    cy.get(".product-detail").should("exist");
  })
})