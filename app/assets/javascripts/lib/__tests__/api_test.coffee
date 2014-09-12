jest.dontMock("../api")


sharedRequestMethodBehaviour = (method) ->
  describe "#{method} Requests", ->
    beforeEach ->
      @jquery = require("jquery")
      spyOn(@jquery, 'ajax')

    it "calls endpoint using #{method} method", ->
      Api = require("../api")
      Api[method.toLowerCase()]("/")

      options = @jquery.ajax.calls[0].args[0]
      expect(options.type).toBe(method)

    it "passes data along with the request when supplied", ->
      data = { prop: "value" }
      Api = require("../api")
      Api[method.toLowerCase()]("/", data)

      options = @jquery.ajax.calls[0].args[0]
      expect(options.data).toBe(data)

describe "Api", ->
  describe "ajax defaults", ->
    beforeEach ->
      @jquery = require("jquery")
      spyOn(@jquery, 'ajax')

    it "sets the accept header appropriately", ->
      Api = require("../api")
      Api.get("/")

      options = @jquery.ajax.calls[0].args[0]
      expect(options.accept).toBe("vnd.pseudocms.v1+json")

    it "includes the auth header when the token is known", ->
      Api = require("../api")
      Api.storeAuthToken("myToken")
      Api.get("/")

      options = @jquery.ajax.calls[0].args[0]
      expect(options.headers["Authorization"]).toBe("Bearer myToken")

    it "doesn't include the auth header when the token is unknown", ->
      Api = require("../api")
      Api.get("/")

      options = @jquery.ajax.calls[0].args[0]
      expect(options.header).toBeUndefined()

  describe "GET Requests", -> sharedRequestMethodBehaviour("GET")
  describe "POST Requests", -> sharedRequestMethodBehaviour("POST")
  describe "PUT Requests", -> sharedRequestMethodBehaviour("PUT")
  describe "PATCH Requests", -> sharedRequestMethodBehaviour("PATCH")
  describe "DELETE Requests", -> sharedRequestMethodBehaviour("DELETE")
