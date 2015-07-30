React = require( 'react' )

{Grid, Row, Col, Panel, TabbedArea, TabPane} = require('react-bootstrap')
MockPigeonPane = require('./MockPigeonPane')

Main = React.createClass
  displayName: 'Main',
  render: ->
    <TabbedArea defaultActiveKey={1}>
      <TabPane eventKey={1} tab='Mock Pigeon'>
        <MockPigeonPane />
      </TabPane>
      <TabPane eventKey={2} tab='Tools'>No tools yet</TabPane>
    </TabbedArea>

module.exports = Main
