/// <reference types="cypress" />

Cypress.config('baseurl', "http://localhost:3000/")

describe('carttests', () => {
  beforeEach(() => {
    Cypress.config('baseurl', "http://localhost:3000/")
    cy.visit("http://localhost:3000/")
  })

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  })
  
  it("should click on add to cart, causing cart to increase by 1", () => {
    cy.get(':nth-child(2) > .end-0 > .nav-link').contains('(0)')
    cy.get('.products > :nth-child(1) > div > .button_to > .btn')
      .click({force: true})
      cy.get(':nth-child(2) > .end-0 > .nav-link').contains('(1)')

  })


});
