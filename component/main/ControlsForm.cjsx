_ = require 'lodash'
React = require 'react'

{Input} = require 'react-bootstrap'

ControlsForm = React.createClass
  displayName: 'ControlsForm',

  render: ->
    <form>
      <Input type="checkbox" label='Subscription Email Enabled' onChange={this.props._onEmailEnabledCheckboxChange} />
    </form>

module.exports = ControlsForm
