React = require( 'react' )

{Panel} = require 'react-bootstrap'

ServerLog = React.createClass
  displayName: 'ServerLog',

  render: ->
    <div className="log">{<Panel key={index}>{item}</Panel> for index, item of this.props.buffer}</div>

module.exports = ServerLog
