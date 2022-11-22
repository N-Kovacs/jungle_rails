/// <reference types="cypress" />


describe('hometests', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/')
  })

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  })
  it("should click on a product to be taken to page", () => {
    cy.get('.products > :nth-child(1)')
      .click()
    cy.get('.products-show').should("be.visible")

  })


});
