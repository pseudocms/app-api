_                               = require("lodash")
React                           = require("react")
Page                            = require("../components/page")
{Card, CardHeader, CardContent} = require("../components/card")

renderComponent = (id, component) ->
  React.renderComponent(eval(component), document.getElementById(id))

module.exports =
  init: ->
    components = _.remove(reactComponents || [])

    _.each components, (component, index) ->
      renderComponent(component.id, atob(component.component))
