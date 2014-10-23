jest.dontMock("jquery")
jest.dontMock("../api")

localStorage =
  getItem: (name) ->
    return "myAuthToken"

$   = require("jquery")
API = require("../api")
API.setStorage(localStorage)

sharedRequestBehaviour = (method) ->
  it "makes a #{method} request", ->
    spyOn($, "ajax")
    API[method.toLowerCase()]("/")

    options = $.ajax.calls[0].args[0]
    expect(options.type).toBe(method)

  it "sends data when supplied", ->
    spyOn($, "ajax")
    data = { prop: "value" }
    API[method.toLowerCase()]("/", data)

    options = $.ajax.calls[0].args[0]
    expect(options.data).toBe(data)

describe "API", ->

  describe "defaults", ->
    it "sets the accept header to the API version", ->
      spyOn($, "ajax")
      API.get("/")

      options = $.ajax.calls[0].args[0]
      expect(options.accept).toBe("vnd.pseudocms.v1+json")

    it "includes the auth token in the Authorization header", ->
      spyOn($, "ajax")
      API.get("/")

      options = $.ajax.calls[0].args[0]
      expect(options.headers["Authorization"]).toBe("Bearer #{localStorage.getItem()}")

  describe "GET Requests", -> sharedRequestBehaviour("GET")
  describe "POST Requests", -> sharedRequestBehaviour("POST")
  describe "PUT Requests", -> sharedRequestBehaviour("PUT")
  describe "PATCH Requests", -> sharedRequestBehaviour("PATCH")
  describe "DELETE Requests", -> sharedRequestBehaviour("DELETE")
