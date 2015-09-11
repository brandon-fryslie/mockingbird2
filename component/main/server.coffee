path = require 'path'

express = require 'express'
expressWs = require('express-ws')
router = express.Router()


# pass in some handlers here

start_up_server = (opts) ->

  OK_HANDLER = (data = 'OK') ->
    (req, res) -> res.status(200).send(data)

  app = express()
  expressWs app

  router.use (req, res, next) ->
    # opts?.middleware? req, res

    opts.logger "request - #{req.method} #{req.url.replace(/\?.*?$/, '')} #{("#{k}=#{v}" for k, v of req.query).join(' ')}"
    next()

  # ----------------- RULE ROUTES ---------------
  router.route('/rule')
        .get(OK_HANDLER())
        .post(OK_HANDLER())

  router.route('/rule/:id')
        .get(OK_HANDLER())
        .put(OK_HANDLER())
        .patch(OK_HANDLER())
        .delete(OK_HANDLER())
  # --------------- / RULE ROUTES ---------------

  # ----------------- WATCH ROUTES ---------------
  router.route('/watch/:artifact_uuid')
        .get(opts.watchGetHandler)
        .post(opts.watchPostHandler)
        .delete(opts.watchDeleteHandler)

  router.route('/watch/:artifactuuid/user/:user_uuid')
        .get(opts.watchGetHandler)
        .post(opts.watchPostHandler)
        .delete(opts.watchDeleteHandler)

  # wtf is this for
  router.route('/watch/user/:user_uuid')
        .get(opts.watchGetHandler)

  router.route('/watch/')
        .get(opts.getWatchesHandler)
  # --------------- / WATCH ROUTES ---------------


  # ----------------- WEBHOOK ROUTES ---------------
  router.route('/webhook')
        .get(OK_HANDLER('webhook'))
  # --------------- / WEBHOOK ROUTES ---------------

  router.route('/email_enabled')
        .get(OK_HANDLER())

  app.ws '/_websocket', (ws, res) ->
    ws.on 'message', (msg) ->
      opts.logger "weboscket got message: #{msg}"

  app.use '/api/v1', router
  app.use '/notifications/api/v1/', router
  # app.use router

  # app.all '*', (req, res) ->
  #   opts.logger "#{req.method} #{req.url}: fell through to default handler"
  #   res.status(200).send('default handler')

  port = 3200

  server = app.listen "#{port}"

  url = "http://localhost:#{port}"

  opts.logger """starting mock pigeon: #{url}"""

  server

module.exports = start_up_server