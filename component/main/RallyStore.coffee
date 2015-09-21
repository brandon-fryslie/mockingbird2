_ = require 'lodash'

{EventEmitter} = require 'events'

class RallyStore extends EventEmitter

  defaultServer: 'http://rally.dev:8999'
  defaultUsername: 'ue@test.com'
  defaultPassword: 'Password'

  constructor: ->
    @server = localStorage.getItem('rally-server') ? @defaultServer
    @username = localStorage.getItem('rally-username') ? @defaultUsername
    @password = localStorage.getItem('rally-password') ? @defaultPassword

  setData: (data) ->
    for key, value of data
      localStorage.setItem "rally-#{key}", value

    _.merge @, data
    @emit 'update'

  setServer: (server) ->
    @setData server: server

  setUsername: (username) ->
    @setData username: username

  setPassword: (password) ->
    @setData password: password

  getServer: -> @server
  getUsername: -> @username
  getPassword: -> @password

module.exports = new RallyStore