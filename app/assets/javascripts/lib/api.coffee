$ = require("jquery")

TOKEN_KEY = "pseudocms.authtoken"
ACCEPT_HEADER = "vnd.pseudocms.v1+json"

storageContainer = null

getRequestOptions = ->
  token = (storageContainer || localStorage).getItem(TOKEN_KEY)
  options =
    accept: ACCEPT_HEADER
    headers:
      "Authorization": "Bearer #{token}"

  options

makeRequest = (method, url, data) ->
  options = getRequestOptions()
  options.url = url
  options.type = method
  options.data = data if data
  $.ajax(options)

Api =
  get: (url, data) -> makeRequest("GET", url, data)
  post: (url, data) -> makeRequest("POST", url, data)
  put: (url, data) -> makeRequest("PUT", url, data)
  patch: (url, data) -> makeRequest("PATCH", url, data)
  delete: (url, data) -> makeRequest("DELETE", url, data)
  setStorage: (container) -> storageContainer = container

module.exports = Api
