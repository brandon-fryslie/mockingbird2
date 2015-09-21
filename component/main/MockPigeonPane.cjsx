_ = require 'lodash'
React = require 'react'

{Grid, Row, Col, Panel, TabbedArea, TabPane, ButtonToolbar, Button, Input} = require 'react-bootstrap'
ServerLog = require('./ServerLog')
ArtifactPanel = require('./ArtifactPanel')

start_server = require('./server')

watchesStore = require('./WatchesStore')
watchesStore.setWatches require('./watches.json')

MockPigeon = require('./MockPigeon')
pigeon = new MockPigeon watchesStore

MockPigeonPane = React.createClass
  displayName: 'MockPigeonPane'

  _setState: (data) ->
    @setState _.assign {}, @state, data

  getInitialState: ->
    logBuffer: []
    port: 3200
    running: false

  componentWillMount: ->
    @_startServer()

  componentDidUnmount: ->
    @_stopServer()

  _onPortChange: (e) ->
    @_setState port: e.target.value

  _startServer: ->
    unless @state.running
      @server = start_server
        port: @state.port
        logger: @_logger
        getWatchesHandler: pigeon.getWatches
        watchGetHandler: pigeon.getWatch
        watchPostHandler: pigeon.postWatch
        watchDeleteHandler: pigeon.deleteWatch
      @setState running: true

  _stopServer: ->
    if @state.running
      @server?.close()
      @setState running: false
      @_logger 'Stopping server...'

  _logger: (str) ->
    newBuffer = @state.logBuffer
    newBuffer.unshift str
    @setState logBuffer: newBuffer

  render: ->
    <Panel>
      <ButtonToolbar>
        <Button onClick={@_startServer}>Start Server</Button>
        <Button onClick={@_stopServer}>Stop Server</Button>
      </ButtonToolbar>
      <Input type="text" label='Port' value={@state.port} onChange={this._onPortChange} />
      <ServerLog buffer={@state.logBuffer} />
    </Panel>

module.exports = MockPigeonPane
