React = require( 'react' )

{Panel} = require 'react-bootstrap'

ServerLog = React.createClass
  displayName: 'ServerLog',

  render: ->
    rows = for item in this.props.buffer
      <Panel>{item}</Panel>

    <div class="log">{rows}</div>

module.exports = ServerLog
