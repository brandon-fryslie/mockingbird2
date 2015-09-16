_ = require 'lodash'

rally = require 'rally'

RallyStore = require './RallyStore'

{EventEmitter} = require 'events'

class AlmApi extends EventEmitter

  constructor: ->
    @setRallyRestApi()
    RallyStore.addListener 'update', => @setRallyRestApi()

  setRallyRestApi: ->
    @api = rally
      user: RallyStore.getUsername()
      pass: RallyStore.getPassword()
      server: RallyStore.getServer()
      requestOptions:
        headers:
          'X-RallyIntegrationName': 'MockPigeon'
          'X-RallyIntegrationVendor': 'Rally'
          'X-RallyIntegrationVersion': '0.0.1'

    @emit 'update'

module.exports = new AlmApi