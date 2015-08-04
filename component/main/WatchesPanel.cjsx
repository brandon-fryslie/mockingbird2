_ = require 'lodash'
React = require 'react'

{Panel, Table} = require 'react-bootstrap'

WatchesPanel = React.createClass
  displayName: 'WatchesPanel',

  render: ->
    attributes = _(_.first(this.props.watches)).keys().sort().remove(((s) -> s isnt 'watchers')).value()

    header_cells = (<th>{attr}</th> for attr in attributes)

    rows = for watch in this.props.watches
      <tr>{(<td>{watch[attr]}</td> for attr in attributes)}</tr>

    <Panel>
      <h2>Your Watches</h2>
      <Table striped bordered condensed hover>
        <thead>
          <tr>
            {header_cells}
          </tr>
        </thead>
        <tbody>
          {rows}
        </tbody>
      </Table>
    </Panel>

module.exports = WatchesPanel
