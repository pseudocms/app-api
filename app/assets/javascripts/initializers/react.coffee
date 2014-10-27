_                                           = require("lodash")
React                                       = require("react")

{Card, CardHeader, CardFooter, CardContent} = require("../components/card")
Errors                                      = require("../components/errors")
{Form, FormField}                           = require("../components/form")
{Grid, GridCell}                            = require("../components/grid")
Heading                                     = require("../components/heading")
Icon                                        = require("../components/icon")
{Link, Navigation}                          = require("../components/navigation")
SiteList                                    = require("../components/site_list")
Toolbar                                     = require("../components/toolbar")

renderComponent = (id, component) ->
  React.renderComponent(eval(component), document.getElementById(id))

module.exports =
  init: ->
    return unless reactComponents?
    components = _.remove(reactComponents || [])

    _.each components, (component, index) ->
      renderComponent(component.id, atob(component.component))
