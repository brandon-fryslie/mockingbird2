_ = require 'lodash'

rally = require 'rally'

{EventEmitter} = require 'events'

Alm = require './AlmApi'

class ArtifactStore extends EventEmitter

  constructor: ->
    Alm.addListener 'update', => @load()

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
    Alm.api.query(
      type: 'artifact'
      fetch: ['Project']
    ).then((results) =>
      @setData results.Results
      @emit 'update'
    )

module.exports = new ArtifactStore