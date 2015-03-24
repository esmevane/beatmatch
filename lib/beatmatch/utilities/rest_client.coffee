rest            = require('rest')
mime            = require('rest/interceptor/mime')
queryString     = require('querystring')
{ Credentials } = require('../../../config/credentials')

_credentials =
  key:    Credentials.consumerKey
  secret: Credentials.consumerSecret

class RestClient
  constructor: ({ @url, @resource }) ->
    @rest = rest.wrap(mime)
    @path = "#{@url}/#{@resource}?#{queryString.stringify(_credentials)}"

    @headers =
      'Content-Type': 'application/json',
      'User-Agent':   'BeatmatchClient/0.1.0'

  get: -> @rest({ @path, @headers })

module?.exports = RestClient
