_           = require 'underscore'
http        = require 'http'
queryString = require 'querystring'
url         = require 'url'

class Client
  constructor: ({ @key, @secret, @root, @port, @callbacks }) ->
    @callbacks ?= {}
    @port      ?= 80
    @root      ?= 'http://localhost'
    @http       = http
    @config     = @_buildConfig()

  on: (namespace, callback) ->
    callbacks = {}
    callbacks[key] = value for key, value of @callbacks
    callbacks[namespace] = callback

    new Client({ @key, @secret, @root, @port, callbacks })

  onData:  (callback) -> @on('data', callback)
  onError: (callback) -> @on('error', callback)
  onEnd:   (callback) -> @on('end', callback)

  params: (queryParams) ->
    parameters = queryString.stringify(queryParams)
    root       = "#{@root}?#{parameters}"

    new Client({ @key, @secret, root, @port, @callbacks })

  perform: ->
    { error, data, end } = @callbacks

    handleResponse = (response) ->
      response.setEncoding('utf-8')
      response.on('data', data)
      response.on('end', end)

    @http.request(@config, handleResponse).on('error', error).end()

  resource: (resource) ->
    root = "#{@root}/#{resource}"
    new Client({ @key, @secret, root, @port, @callbacks })

  _buildConfig: ->
    { host, path } = url.parse(@root)

    hostname: host
    port:     @port
    path:     path
    method:   'GET'
    headers:
      'Content-Type': 'application/json',
      'User-Agent':   'BeatmatchClient/0.1.0'

module?.exports = Client
