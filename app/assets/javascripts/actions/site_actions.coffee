Dispatcher = require("../dispatcher")
Constants  = require("../constants/site_constants")
Api        = require("../lib/api")
Pager      = require("../lib/pager")

Actions =
  getAll: ->
    Dispatcher.dispatchAction(actionType: Constants.GET_SITES)

    op = Api.get("/sites")

    op.done (data, status, xhr) ->
      pagedResult = Pager.paginate(xhr)

      Dispatcher.dispatchData
        actionType: Constants.GET_SITES_COMPLETED
        data: pagedResult

    op.fail (xhr, status, errorThrown) ->
      Dispatcher.dispatchAction
        actionType: Constants.GET_SITES_FAILED
        data: xhr

module.exports = Actions
