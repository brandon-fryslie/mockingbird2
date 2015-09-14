_ = require 'lodash'

rally = require 'rally'

{EventEmitter} = require 'events'

RallyStore = require './RallyStore'

class ArtifactStore extends EventEmitter

  constructor: ->
    @setRallyRestApi()
    RallyStore.addListener 'update', => @setRallyRestApi()

  setRallyRestApi: ->
    console.log 'setting rally rest api', RallyStore.getServer(), RallyStore.getUsername(), RallyStore.getPassword()
    @restApi = rally
      user: RallyStore.getUsername()
      pass: RallyStore.getPassword()
      server: RallyStore.getServer()
      requestOptions:
        headers:
          'X-RallyIntegrationName': 'MockPigeon'
          'X-RallyIntegrationVendor': 'Rally'
          'X-RallyIntegrationVersion': '0.0.1'

  getById: (uuid) -> _.find this.artifacts, _refObjectUUID: uuid

  isWatching: (uuid) -> @getById(uuid).watching

  getArtifacts: -> @artifacts

  setData: (data) ->
    @artifacts = data

  watchByUUID: (uuid) -> @watch @getById(uuid)

  watch: (artifact) ->
    artifact.watching = true
    @emit 'update'

  unwatchByUUID: (uuid) -> @unwatch @getById(uuid)

  unwatch: (artifact) ->
    artifact.watching = false
    @emit 'update'

  load: ->
    debugger
    @restApi.query(
      type: 'artifact'
      fetch: ['Project']
    ).then((results) =>
      @setData results.Results
      @emit 'update'
    )

module.exports = new ArtifactStore