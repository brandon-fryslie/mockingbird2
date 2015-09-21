_ = require 'lodash'

rally = require 'rally'

Alm = require './AlmApi'

AbstractPagedStore = require './AbstractPagedStore'

class ArtifactStore extends AbstractPagedStore

  type: 'artifact'

  fetch: ['Project']

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

module.exports = new ArtifactStore