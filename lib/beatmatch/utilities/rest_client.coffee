rest            = require('rest')
mime            = require('rest/interceptor/mime')
queryString     = require('querystring')
{ Credentials } = require('../../../config/credentials')

_beatmatchCredentials =
  key:    Credentials.consumerKey
  secret: Credentials.consumerSecret

_credentialString = -> queryString.stringify(_beatmatchCredentials)

class RestClient
  constructor: ({ @url, @resource }) ->
    @rest = rest.wrap(mime)
    @path = "#{@url}/#{@resource}?#{_credentialString()}"

    @headers =
      'Content-Type': 'application/json',
      'User-Agent':   'BeatmatchClient/0.1.0'

  get: -> @rest({ @path, @headers })

module?.exports = RestClient
