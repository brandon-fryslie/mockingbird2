React = require( 'react' )

{Panel, ListGroup, ListGroupItem} = require 'react-bootstrap'

ServerLog = React.createClass
  displayName: 'ServerLog',

  render: ->
    <Panel header="Log">
      <ListGroup header="Log">
        {<ListGroupItem key={idx}>{item}</ListGroupItem> for idx, item of @props.buffer}
      </ListGroup>
    </Panel>

module.exports = ServerLog
