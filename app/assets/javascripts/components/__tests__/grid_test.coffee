###* @jsx React.Dom ###

jest.dontMock("../grid")

React            = require("react/addons")
Test             = React.addons.TestUtils
{Grid, GridCell} = require("../grid")

describe "Grid", ->

  it "transfers props to grid", ->
    grid = Test.renderIntoDocument(`<Grid className="grid--column" />`)
    node = Test.findRenderedDOMComponentWithTag(grid, "div").getDOMNode()
    expect(node.className).toBe("grid grid--column")

  it "renders children as cells", ->
    grid = Test.renderIntoDocument `
      <Grid>
        <GridCell>
          Some Content
        </GridCell>
      </Grid>
    `
    Test.findRenderedDOMComponentWithClass(grid, "grid__cell")

  describe "Grid Cell", ->

    it "tranfers props to cell", ->
      cell = Test.renderIntoDocument(`<GridCell className="grid__cell--half" />`)
      node = Test.findRenderedDOMComponentWithTag(cell, "div").getDOMNode()
      expect(node.className).toBe("grid__cell grid__cell--half")

    it "renders children", ->
      cell = Test.renderIntoDocument(`<GridCell className="grid__cell--half">Content Here</GridCell>`)
      node = Test.findRenderedDOMComponentWithTag(cell, "div").getDOMNode()
      expect(node.innerHTML).toBe("Content Here")
