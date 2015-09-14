_ = require 'lodash'
React = require 'react'

RallyStore = require './RallyStore'

{Grid, Row, Col, Panel, TabbedArea, TabPane, Input} = require 'react-bootstrap'

RallyPane = React.createClass
  displayName: 'RallyPane',

  getInitialState: ->
    server: RallyStore.getServer()
    username: RallyStore.getUsername()
    password: RallyStore.getPassword()

  _onRallyServerDataChange: (e) ->
    data = {}
    attr = e.target.getAttribute('data-attribute')
    data[attr] = e.target.value
    RallyStore.setData data
    @setState _.merge {}, @state, data

  render: ->
    <form>
      <Input type="text" label='Server' value={@state.server} data-attribute="server" onChange={this._onRallyServerDataChange} />
      <Input type="text" label='Username' value={@state.username} data-attribute="username" onChange={this._onRallyServerDataChange} />
      <Input type="text" label='Password' value={@state.password} data-attribute="password" onChange={this._onRallyServerDataChange} />
    </form>


module.exports = RallyPane
