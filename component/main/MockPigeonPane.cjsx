_ = require 'lodash'
React = require 'react'

{Grid, Row, Col, Panel, TabbedArea, TabPane} = require 'react-bootstrap'
ServerLog = require('./ServerLog')
ArtifactPanel = require('./ArtifactPanel')

start_server = require('./server')

watchesStore = require('./WatchesStore')
watchesStore.setWatches require('./watches.json')

MockPigeon = require('./MockPigeon')
pigeon = new MockPigeon watchesStore

MockPigeonPane = React.createClass
  displayName: 'MockPigeonPane'

  getInitialState: ->
    logBuffer: []

  componentWillMount: ->
    @server = start_server
      logger: this._logger
      getWatchesHandler: pigeon.getWatches
      watchGetHandler: pigeon.getWatch
      watchPostHandler: pigeon.postWatch
      watchDeleteHandler: pigeon.deleteWatch

  componentDidUnmount: ->
    @server.close()

  _logger: (str) ->
    newBuffer = this.state.logBuffer
    newBuffer.unshift str
    this.setState logBuffer: newBuffer

  render: ->
    <Grid>
      <Row className='show-grid'>
        <Col md={9}>
          <ArtifactPanel logger={this._logger} />
        </Col>
        <Col md={3}>
          <ServerLog buffer={this.state.logBuffer} />
        </Col>
      </Row>
    </Grid>

module.exports = MockPigeonPane