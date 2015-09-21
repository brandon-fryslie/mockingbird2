_ = require 'lodash'

{EventEmitter} = require 'events'

Alm = require './AlmApi'

class AbstractPagedStore extends EventEmitter

  constructor: ->
    @pageSize = 200
    @startIndex = 1

  getPage: -> @data

  setData: (@data) ->

  load: ->
    Alm.api.query(
      type: @type
      fetch: @fetch
      start: @startIndex
      pageSize: @pageSize
    ).then((results) =>
      @totalResultCount = results.TotalResultCount
      @setData results.Results
      @emit 'update'
    )


module.exports = AbstractPagedStore