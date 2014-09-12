_     = require("lodash")
React = require("react")

loadedComponents = {}

camelize = (string) ->
  string.replace /(?:^|[-_])(\w)/g, (dontCard, char) ->
    if char then char.toUpperCase() else ""

registerComponents = (components) ->
  loadedComponents = components

renderComponents = ->
  _.forIn (window.reactComponents || {}), (component, elementId) ->
    instance = loadedComponents[component]()
    React.renderComponent(instance, document.getElementById(elementId))

ComponentManager =
  initialize: (options) ->
    registerComponents(options.components)
    renderComponents()

module.exports = ComponentManager
