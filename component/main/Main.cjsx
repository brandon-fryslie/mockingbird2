React = require( 'react' )

{Grid, Row, Col, Panel, TabbedArea, TabPane, Input} = require('react-bootstrap')
ArtifactPanel = require('./ArtifactPanel')
MockPigeonPane = require('./MockPigeonPane')
RallyPane = require('./RallyPane')
UsersPane = require('./UsersPane')
ToolsPane = require('./ToolsPane')
ServerLog = require('./ServerLog')

Main = React.createClass

  displayName: 'Main'

  # componentWillMount: ->
  #   @setState defaultActiveTabKey: 1

  # componentDidUnmount: ->
  #   @setState defaultActiveTabKey: 1

  getInitialState: ->
    logBuffer: []

  _logger: (str) ->
    newBuffer = @state.logBuffer
    newBuffer.unshift str
    @setState logBuffer: newBuffer

  render: ->
    <Grid fluid>
      <Row>

        <Col md={2}>
          <ServerLog title={"Log"} buffer={@state.logBuffer} />
        </Col>
        <Col md={10}>
          <TabbedArea defaultActiveKey={1}>
            <TabPane eventKey={1} tab='Mock Pigeon'>
              <MockPigeonPane mainLogger={@_logger} />
            </TabPane>
            <TabPane eventKey={2} tab='Artifacts'>
              <ArtifactPanel mainLogger={@_logger} />
            </TabPane>
            <TabPane eventKey={3} tab='Users'>
              <UsersPane mainLogger={@_logger} />
            </TabPane>
            <TabPane eventKey={4} tab='Tools'>
              <ToolsPane mainLogger={@_logger} />
            </TabPane>
            <TabPane eventKey={5} tab='Rally'>
              <RallyPane mainLogger={@_logger} />
            </TabPane>
          </TabbedArea>
        </Col>
      </Row>
    </Grid>

module.exports = Main
