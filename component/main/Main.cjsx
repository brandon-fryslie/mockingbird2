React = require( 'react' )

{Grid, Row, Col} = require('react-bootstrap')

debugger

start_server = require('./server')
server = start_server


Main = React.createClass
	displayName: 'Main',
	render: ->
    <Grid>
        <Row className='show-grid'>
          <Col xs={12} md={8}></code></Col>
          <Col xs={6} md={4}><code>&lt;{'Col xs={6} md={4}'} /&gt;</code></Col>
        </Row>

        <Row className='show-grid'>
          <Col xs={6} md={4}><code>&lt;{'Col xs={6} md={4}'} /&gt;</code></Col>
          <Col xs={6} md={4}><code>&lt;{'Col xs={6} md={4}'} /&gt;</code></Col>
          <Col xs={6} md={4}><code>&lt;{'Col xs={6} md={4}'} /&gt;</code></Col>
        </Row>

        <Row className='show-grid'>
          <Col xs={6} xsOffset={6}><code>&lt;{'Col xs={6} xsOffset={6}'} /&gt;</code></Col>
        </Row>

        <Row className='show-grid'>
          <Col md={6} mdPush={6}><code>&lt;{'Col md={6} mdPush={6}'} /&gt;</code></Col>
          <Col md={6} mdPull={6}><code>&lt;{'Col md={6} mdPull={6}'} /&gt;</code></Col>
        </Row>
      </Grid>

module.exports = Main
