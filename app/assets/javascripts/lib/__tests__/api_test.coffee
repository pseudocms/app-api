jest.dontMock("../api.coffee")

describe "Api", ->
  beforeEach ->
    @api = require("../api.coffee")

  #describe "ajax defaults", ->
    #beforeEach ->
      #@request = @api.get "/",
        #username: "user"

    #it "sets the accept header appropriately", ->
      #expect(@request.accept).toBe("vnd.pseudocms.v1+json")
