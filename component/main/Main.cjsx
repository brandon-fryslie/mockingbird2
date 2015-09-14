React = require( 'react' )

{Grid, Row, Col, Panel, TabbedArea, TabPane} = require('react-bootstrap')
MockPigeonPane = require('./MockPigeonPane')
RallyPane = require('./RallyPane')
ArtifactPanel = require('./ArtifactPanel')

Main = React.createClass

  displayName: 'Main'

  render: ->
    <TabbedArea defaultActiveKey={1}>
      <TabPane eventKey={1} tab='Mock Pigeon'>
        <MockPigeonPane />
      </TabPane>
      <TabPane eventKey={2} tab='Tools'>
        <div>Nothing yet</div>
      </TabPane>
      <TabPane eventKey={3} tab='Rally'>
        <RallyPane />
      </TabPane>
    </TabbedArea>

module.exports = Main
