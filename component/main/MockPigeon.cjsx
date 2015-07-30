_ = require 'lodash'

class MockPigeon

  constructor: (@watchesStore) ->

  getWatch: (req, res) =>
    res.status(200).send('GETTING A WATCH FROM PIGEON')

  getWatches: (req, res) =>
    res.status(200).json(@watchesStore.getWatches())

  setWatches: (data) =>
    @watches = data

module.exports = MockPigeon