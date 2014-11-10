$(document).on "turbograft:remote:init", (event) ->
  token = $("meta[name=csrf-token]").attr("content")
  event.originalEvent.data.xhr.setRequestHeader("X-CSRF-Token", token)
