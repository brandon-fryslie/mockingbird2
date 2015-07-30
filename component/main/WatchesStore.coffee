_ = require 'lodash'

class WatchesStore

  constructor: (@watches = []) ->

  getWatch: (uuid) ->
    _.find @watches, {uuid: uuid}

  getWatches: ->
    @watches

  setWatches: (data) ->
    @watches = data

module.exports = new WatchesStore