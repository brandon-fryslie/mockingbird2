_ = require 'lodash'

rally = require 'rally'

AbstractPagedStore = require './AbstractPagedStore'

Alm = require './AlmApi'

class UsersStore extends AbstractPagedStore

  constructor: ->
    Alm.addListener 'update', => @load()

  getUsers: -> @users

  setData: (data) ->
    @users = data

  fetch: [
    'DisplayName'
    'EmailAddress'
    'FirstName'
    'LastName'
    'LastPasswordUpdateDate'
    'Role'
    'SubscriptionAdmin'
    'SubscriptionID'
    'SubscriptionPermission'
    'TeamMemberships'
    'UserName'
    'UserPermissions'
    'UserProfile'
    'WorkspacePermission'
  ]

  type: 'user/'

module.exports = new UsersStore