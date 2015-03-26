rest            = require('rest')
mime            = require('rest/interceptor/mime')
queryString     = require('querystring')
{ Credentials } = require('../../../config/credentials')

_beatmatchCredentials =
  key:    Credentials.consumerKey
  secret: Credentials.consumerSecret

_credentialString = (params) ->
  creds      = _beatmatchCredentials
  creds[key] = value for key, value of params

  queryString.stringify(creds)

class RestClient
  constructor: ({ @url, @resource, params }) ->
    @rest    = rest.wrap(mime)
    @path    = "#{@url}/#{@resource}?#{_credentialString(params)}"
    @headers = 'Content-Type': 'application/json'

    unless process.browser
      @headers['User-Agent'] = 'BeatmatchClient/0.1.0'

  get: -> @rest({ @path, @headers })

module?.exports = RestClient
