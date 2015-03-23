http        = require 'http'
queryString = require 'querystring'
Client      = lib 'beatmatch/client'

describe 'Client usage', ->
  it "uses the http API correctly", ->
    data  = (chunk) ->
    end   = ->
    error = ->

    receiver = {}
    httpMock =
      request: (config, responseHandler) ->
        receiver.config          = config
        receiver.responseHandler = responseHandler

        on: (namespace, callback) ->
          receiver.namespace = namespace
          receiver.callback  = callback

          end: -> receiver.endCalled = true

    client = new Client(root: 'http://api.discogs.com')
      .onData(data)
      .onEnd(end)
      .onError(error)

    client.http = httpMock
    client.perform()

    expect(receiver.config).to.be.eql        client.config
    expect(receiver.responseHandler).to.be.a 'function'
    expect(receiver.namespace).to.be.eql     'error'
    expect(receiver.callback).to.equal       error
    expect(receiver.endCalled).to.be.true
