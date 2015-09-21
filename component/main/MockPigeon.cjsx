_ = require 'lodash'

ArtifactStore = require './ArtifactStore'

artifactToWatch = (artifact) ->
  watchers: [
    "UserName": 'rally-user@test.com'
    "DisplayName": 'Reed Nerfton'
    "EmailAddress": "rally-user@test.com"
    "ObjectID": 9213407558
    "user": "98b31fd3-c45c-43bd-8930-17e9d1ed177e"
    "to": "rally-user@test.com"
    "_ref": "/pigeon/rule/55a958ae-cc65-4ec8-a39e-6234e3fe6321"
    "_id": "55a958ae-cc65-4ec8-a39e-6234e3fe6321"
  ]
  tags: [
    "7a3ab98a-f7db-490c-a304-7254bd8318b8"
    "alm-watch"
  ]
  _id: "55a958ae-cc65-4ec8-a39e-6234e3fe6321"
  _ref: "/pigeon/rule/55a958ae-cc65-4ec8-a39e-6234e3fe6321"
  actions: [
      to: "rally-user@test.com"
      user: "98b31fd3-c45c-43bd-8930-17e9d1ed177e"
      task: "email"
  ]
  'last-update': "2015-07-17T19:34:06.790Z"
  expressions: [
      operator: "="
      path: "id"
      'expression-value': artifact._refObjectUUID
  ]
  'subscription-id': 100
  'owner-id': "98b31fd3-c45c-43bd-8930-17e9d1ed177e"
  artifact: artifact


class MockPigeon

  getWatch: (req, res) ->
    res.status(200).send('GETTING A WATCH FROM PIGEON')

  getWatches: (req, res) ->
    debugger
    res.status(200).json(artifactToWatch(artifact) for artifact in ArtifactStore.getArtifacts())

  getWatch: (req, res) ->
    artifact = ArtifactStore.getById req.params.artifact_uuid

    if artifact.watching
      res.status(200).json artifactToWatch artifact
    else
      res.status(204).json {}

  postWatch: (req, res) ->
    artifact_uuid = req.params.artifact_uuid

    if ArtifactStore.isWatching artifact_uuid
      res.status(409).json {}
    else
      ArtifactStore.watchByUUID artifact_uuid
      res.status(200).json {}

  deleteWatch: (req, res) ->
    artifact_uuid = req.params.artifact_uuid

    if ArtifactStore.isWatching artifact_uuid
      ArtifactStore.unwatchByUUID artifact_uuid
      res.status(200).json {}
    else
      res.status(404).json {}



module.exports = MockPigeon