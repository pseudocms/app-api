$ = require("jquery")

TOKEN_STORAGE_KEY = "pseudocmstoken"

storage = {}
storage = localStorage if localStorage?

getAuthToken = ->
  storage[TOKEN_STORAGE_KEY]

getRequestDefaults = ->
  token = getAuthToken()

  defaults =
    accept: "vnd.pseudocms.v1+json"
    headers:
      "Authorization": "Bearer #{token}"

  delete defaults["headers"] unless token
  defaults

makeRequest = (method, url, data) ->
  options = getRequestDefaults()
  options["url"] = url
  options["type"] = method
  options["data"] = data if data
  $.ajax(options)

postLogin = ->
  $("#token").val(getAuthToken()).parents("form:first").submit()

Api =
  get: (url, data) -> makeRequest("GET", url, data)
  post: (url, data) -> makeRequest("POST", url, data)
  put: (url, data) -> makeRequest("PUT", url, data)
  patch: (url, data) -> makeRequest("PATCH", url, data)
  delete: (url, data) -> makeRequest("DELETE", url, data)
  storeAuthToken: (token) -> storage[TOKEN_STORAGE_KEY] = token
  clearAuthToken: -> delete storage[TOKEN_STORAGE_KEY]
  postLoginToken: -> postLogin()

module.exports = Api
