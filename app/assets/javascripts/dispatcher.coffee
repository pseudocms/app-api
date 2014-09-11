Dispatcher = require("flux").Dispatcher
copyProperties = require("react/lib/copyProperties")

AppDispatcher = copyProperties new Dispatcher,
  dispatchAction: (action) ->
    @dispatch
      source: "VIEW_ACTION"
      action: action

module.exports = AppDispatcher
