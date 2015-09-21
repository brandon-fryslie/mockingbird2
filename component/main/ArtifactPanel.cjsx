_ = require 'lodash'
React = require 'react'
{openExternal} = require 'shell'

{Grid, Row, Col, Panel, TabbedArea, TabPane, Button, ButtonToolbar, Input, Table} = require 'react-bootstrap'

ArtifactStore = require './ArtifactStore'
RallyStore = require './RallyStore'
Alm = require './AlmApi'

ArtifactPanel = React.createClass
  displayName: 'ArtifactPanel'

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

  _realWatch: (e) ->
    # send request to pigeon

  _touchArtifact: (record) ->
    date = new Date()
    Alm.api.update(
      ref: record._ref
      data:
        Notes: "Updated #{date.getHours()}:#{date.getMinutes()}:#{date.getSeconds()} #{date.getMonth()+1}/#{date.getDate()}/#{date.getFullYear()}"
    ).then (result) =>
      @props.mainLogger "Updated artifact! #{@_makeDetailLink(artifact)}"
      console.log 'updated artifact!', result

  render: ->
    table = if @state.artifacts.length is 0
      <div>No artifacts loaded</div>
    else if @state.error
      <div>{@state.error}</div>
    else
      rows = for artifact in @state.artifacts
        <tr key={artifact._refObjectUUID}>
          <td>
            <span>
              <a onClick={@_onLinkClick} href={@_makeDetailLink(artifact)}>{artifact.FormattedID}</a>:&nbsp;{artifact._refObjectName}&nbsp;(<a onClick={@_onLinkClick} href={artifact._ref}>WSAPI</a>)
            </span>
          </td>
          <td>
            <Input type='checkbox' label=" " checked={artifact.watching} onChange={@onWatchingCheckboxChange} data-id={artifact._refObjectUUID} />
          </td>
          <td>
            <Button onClick={@_realWatch(artifact)}>Watch</Button>
          </td>
          <td>
            <Button onClick={=> @_touchArtifact(artifact)}>Touch</Button>
          </td>
        </tr>

      <Table striped bordered condensed hover>
        <thead>
          <tr><th>&nbsp;</th><th>Mock Watch</th><th>Real Watch</th></tr>
        </thead>
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
