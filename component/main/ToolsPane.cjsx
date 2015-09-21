_ = require 'lodash'
React = require 'react'

RallyStore = require './RallyStore'

Alm = require './AlmApi'

queryUtils = require('rally').util.query

{Grid, Row, Col, Panel, TabbedArea, TabPane, Input, Table, Button} = require 'react-bootstrap'

Tools = React.createClass
  displayName: 'Tools'

  getInitialState: ->
    pokeAlmSliderValue: 1

  _onPokeAlmSliderChange: ->

  render: ->
    <Panel>
      <form>
        <h4>Poke ALM</h4>
        <Input type="checkbox" label="Poke ALM" />
         <input id="mySlider"
                  type="range"
                  value={@state.pokeAlmSliderValue}
                  onChange={@_onPokeAlmSliderChange}
                  label="Pokes per second"
                  min=1
                  max=100
                  onInput={@_handlePokeAlmSliderChange}
                  step=5 />
      </form>
    </Panel>


module.exports = Tools
