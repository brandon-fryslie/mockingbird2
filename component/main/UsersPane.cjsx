_ = require 'lodash'
React = require 'react'
{openExternal} = require 'shell'

{Grid, Row, Col, Panel, TabbedArea, TabPane, Button, ButtonToolbar, Input, Table} = require 'react-bootstrap'

UsersStore = require './UsersStore'
RallyStore = require './RallyStore'

ArtifactPanel = React.createClass
  displayName: 'ArtifactPanel',

  getInitialState: ->
    users: []

  componentWillMount: ->
    UsersStore.addListener 'update', =>
      @setState
        users: UsersStore.getUsers()
        error: null
    this._loadUsers();

  _loadUsers: ->
    UsersStore.load().fail (error) =>
      @setState _.merge {}, @state, error: 'Error loading users!  Check ALM and credentials.'
      console.log 'Error loading users', error

  componentDidUnmount: ->

  onWatchingCheckboxChange: (e) ->
    if e.target.checked
      UsersStore.watchByUUID e.target.getAttribute('data-id')
    else
      UsersStore.unwatchByUUID e.target.getAttribute('data-id')

  _onLinkClick: (e) ->
    openExternal e.target.getAttribute('href')
    e.preventDefault()

  _getOidFromRef: (ref) -> ref.replace /.*\/(\d)/, '$1'

  _touchUser: (uuid) ->
    console.log 'touching', record

  render: ->
    table = if @state.users.length is 0
      <div>No users loaded</div>
    else if @state.error
      <div>{@state.error}</div>
    else
      rows = for record in @state.users
        <tr data-id={record._refObjectUUID}>
          <td>
            <span>
              <span>{record._refObjectName}</span>&nbsp;(<a onClick={@_onLinkClick} href={record._ref}>WSAPI</a>)
            </span>
          </td>
          <td>
            <Button onClick={=> @_touchUser(record)}>Touch</Button>
          </td>
          <td>
            <Input type='checkbox' label='Email Enabled?' checked={record.figurethisoneout} onChange={@onUserEmailEnabled} />
          </td>
        </tr>

      <Table striped bordered condensed hover>
        <tbody>
          {rows}
        </tbody>
      </Table>

    <Panel>
      <ButtonToolbar>
        <Button onClick={@_loadUsers}>Load Users</Button>
      </ButtonToolbar>
      {table}
    </Panel>

module.exports = ArtifactPanel
