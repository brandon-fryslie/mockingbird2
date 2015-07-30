_ = require 'lodash'
React = require 'react'

{Grid, Row, Col, Panel, TabbedArea, TabPane} = require 'react-bootstrap'
MockPigeonPane = require('./MockPigeonPane')
ServerLog = require('./ServerLog')
ControlsForm = require('./ControlsForm')
WatchesPanel = require('./WatchesPanel')

start_server = require('./server')

watchesStore = require('./WatchesStore')
watchesStore.setWatches require('./watches.json')

MockPigeon = require './MockPigeon'
pigeon = new MockPigeon watchesStore

MockPigeonPane = React.createClass
  displayName: 'MockPigeonPane',

  getInitialState: ->
    logBuffer: []

  componentWillMount: ->
    @server = start_server
      logger: this._logger
      getWatchesHandler: pigeon.getWatches

  componentDidUnmount: ->
    @server.close()

  _logger: (str) ->
    newBuffer = this.state.logBuffer
    newBuffer.unshift str
    this.setState logBuffer: newBuffer

  # _onSubscriptionEmailEnabledCheckboxChange: (e) ->
  #   this.setState _.assign {}, this.state, {subscriptionEmailEnabled: e.target.checked}

  # _onSubscriptionEmailEnabledCheckboxChange: (e) ->
  #   this.setState _.assign {}, this.state, {userEmailEnabled: e.target.checked}

  render: ->
    <Grid>
      <Row className='show-grid'>
        <Col md={3}>
          <ServerLog buffer={this.state.logBuffer} />
        </Col>
        <Col md={9}>
          <WatchesPanel watches={watchesStore.getWatches()} />
        </Col>
      </Row>
    </Grid>

module.exports = MockPigeonPane
