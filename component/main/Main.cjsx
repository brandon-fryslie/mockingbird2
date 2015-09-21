React = require( 'react' )

{Grid, Row, Col, Panel, TabbedArea, TabPane} = require('react-bootstrap')
MockPigeonPane = require('./MockPigeonPane')
RallyPane = require('./RallyPane')
UsersPane = require('./UsersPane')
ToolsPane = require('./ToolsPane')

Main = React.createClass

  displayName: 'Main'

  render: ->
    <TabbedArea defaultActiveKey={1}>
      <TabPane eventKey={1} tab='Mock Pigeon'>
        <MockPigeonPane />
      </TabPane>
      <TabPane eventKey={2} tab='Users'>
        <UsersPane />
      </TabPane>
      <TabPane eventKey={3} tab='Tools'>
        <ToolsPane />
      </TabPane>
      <TabPane eventKey={4} tab='Rally'>
        <RallyPane />
      </TabPane>
    </TabbedArea>

module.exports = Main
