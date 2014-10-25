{EventEmitter} = require("events")
Dispatcher     = require("../dispatcher")
Constants      = require("../constants/site_constants")
Api            = require("../lib/api")
merge          = require("react/lib/merge")

Events =
  CHANGE: "change_event"

SiteStore = merge EventEmitter.prototype,
  addChangeListener: (callback) -> @on(Events.CHANGE, callback)
  removeChangeListener: (callback) -> @removeListener(Events.CHANGE, callback)

  dispatcherIndex: Dispatcher.register (payload) ->
    action = payload.action

    switch action.actionType
      when Constants.GET_SITES_COMPLETED
        SiteStore.emit(Events.CHANGE, action.data)

    true

module.exports = SiteStore
