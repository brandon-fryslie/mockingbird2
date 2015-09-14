_ = require 'lodash'

{EventEmitter} = require 'events'

class RallyStore extends EventEmitter

  constructor: ->
    @server = 'http://rally.dev:8999'
    @username = 'ue@test.com'
    @password = 'Password'

  setData: (data) ->
    _.merge @, data
    @emit 'update'

  getServer: -> @server
  getUsername: -> @username
  getPassword: -> @password

module.exports = new RallyStore