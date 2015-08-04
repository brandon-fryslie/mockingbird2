React = require( 'react' )

{Panel} = require 'react-bootstrap'

ServerLog = React.createClass
  displayName: 'ServerLog',

  render: ->
    <div class="log">{<Panel>{item}</Panel> for item in this.props.buffer}</div>

module.exports = ServerLog
