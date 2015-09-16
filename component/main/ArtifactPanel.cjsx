_ = require 'lodash'
React = require 'react'
{openExternal} = require 'shell'

{Grid, Row, Col, Panel, TabbedArea, TabPane, Button, ButtonToolbar, Input, Table} = require 'react-bootstrap'

ArtifactStore = require './ArtifactStore'
RallyStore = require './RallyStore'

ArtifactPanel = React.createClass
  displayName: 'ArtifactPanel',

  getInitialState: ->
    artifacts: []

  componentWillMount: ->
    ArtifactStore.addListener 'update', =>
      @setState
        artifacts: ArtifactStore.getArtifacts()
        error: null
    this._loadArtifacts();

  _loadArtifacts: ->
    ArtifactStore.load().fail (error) =>
      @setState _.merge {}, @state, error: 'Error loading artifacts!  Check ALM and credentials.'
      console.log 'Error loading artifacts', error

  _watchAll: ->
    _.each ArtifactStore.getArtifacts(), ArtifactStore.watch, ArtifactStore

  _unwatchAll: ->
    _.each ArtifactStore.getArtifacts(), ArtifactStore.unwatch, ArtifactStore

  componentDidUnmount: ->

  onWatchingCheckboxChange: (e) ->
    if e.target.checked
      ArtifactStore.watchByUUID e.target.getAttribute('data-id')
    else
      ArtifactStore.unwatchByUUID e.target.getAttribute('data-id')

  _onLinkClick: (e) ->
    openExternal e.target.getAttribute('href')
    e.preventDefault()

  _getOidFromRef: (ref) -> ref.replace /.*\/(\d)/, '$1'

  _makeDetailLink: (artifact) ->
    type = if artifact._type is 'HierarchicalRequirement' then 'userstory' else artifact._type
    "#{RallyStore.getServer()}/#/#{@_getOidFromRef(artifact.Project._ref)}d/detail/#{type}/#{@_getOidFromRef(artifact._ref)}"

  render: ->
    table = if @state.artifacts.length is 0
      <div>No artifacts loaded</div>
    else if @state.error
      <div>{@state.error}</div>
    else
      rows = for artifact in @state.artifacts
        <tr>
          <td>
            <span>
              <a onClick={@_onLinkClick} href={@_makeDetailLink(artifact)}>{artifact._refObjectName}</a>&nbsp;(<a onClick={@_onLinkClick} href={artifact._ref}>WSAPI</a>)
            </span>
            <span></span>
          </td>
          <td>
            <Input type='checkbox' label='Watching?' checked={artifact.watching} onChange={@onWatchingCheckboxChange} data-id={artifact._refObjectUUID} />
          </td>
        </tr>

      <Table striped bordered condensed hover>
        <tbody>
          {rows}
        </tbody>
      </Table>

    <Panel>
      <ButtonToolbar>
        <Button onClick={@_loadArtifacts}>Load Artifacts</Button>
        <Button onClick={@_watchAll}>Watch All</Button>
        <Button onClick={@_unwatchAll}>Unwatch All</Button>
      </ButtonToolbar>
      {table}
    </Panel>

module.exports = ArtifactPanel
