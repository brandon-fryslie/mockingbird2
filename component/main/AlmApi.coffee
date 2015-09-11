
# AlmApi = require 'churro/apis/AlmApi'



context = Ext.create('Rally.env.Context', require('../alm/context.json'))
server = Ext.create('Rally.env.Server', require('../alm/server.json'))

window.Rally.environment =
  getContext: -> context
  getServer: -> server

Rally.clientmetrics =
  ClientMetricsAggregatorInstance:
    aggregator:
      startSpan: ->
        data:
          tId: 123
          eId: 123

# AlmApi.query('UserStory').then (response) ->
#   debugger
# .catch (err) ->
#   debugger

