http        = require 'http'
queryString = require 'querystring'
Client      = lib 'beatmatch/client'

describe 'Client', ->
  describe 'initialization', ->
    it "accepts consumer keys", ->
      key    = 12345
      client = new Client({ key })

      expect(client.key).to.equal key

    it "accepts consumer secrets", ->
      secret = 67890
      client = new Client({ secret })

      expect(client.secret).to.equal secret

    it "accepts a resource root", ->
      root   = "http://test.host"
      client = new Client({ root })

      expect(client.root).to.equal root

    it "accepts a port", ->
      port   = 80
      client = new Client({ port })

      expect(client.port).to.equal port

  describe '#config', ->
    it "is a standard http.request option set", ->
      root   = "http://test.host"
      client = new Client({ root })

      expectation =
        hostname: 'test.host'
        port:     80
        path:     '/'
        method:   'GET'
        headers:
          'Content-Type': 'application/json'
          'User-Agent':   'BeatmatchClient/0.1.0'

      expect(client.config).to.eql expectation

  describe '#http', ->
    client = new Client({})

    it "is a http object", ->
      expect(client.http).to.be.eql http

  describe '#on', ->
    callback       = -> console.log("Uh oh")
    client         = new Client({ })
    callbackClient = client.on('error', callback)

    it "adds a callback to the correct namespace", ->
      expect(callbackClient.callbacks['error']).to.equal callback

    it 'returns a Client instance', ->
      expect(callbackClient).to.be.instanceof Client

    describe 'convenience methods', ->
      describe '#onData', ->
        callbackClient = client.onData(callback)
        expect(callbackClient.callbacks['data']).to.equal callback

      describe '#onEnd', ->
        callbackClient = client.onEnd(callback)
        expect(callbackClient.callbacks['end']).to.equal callback

      describe '#onError', ->
        callbackClient = client.onError(callback)
        expect(callbackClient.callbacks['error']).to.equal callback

  describe '#params', ->
    params =
      stuff: 'things'
      things: 'stuff'

    root          = "http://test.host"
    client        = new Client({ root })
    parameters    = queryString.stringify(params)
    parameterized = client.params(params)

    it "returns a new Client object", ->
      expect(parameterized).to.be.an.instanceof Client

    it "preconfigures the new path", ->
      expect(parameterized.root).to.equal "#{root}?#{parameters}"

  describe '#resource', ->
    root   = "http://test.host"
    client = new Client({ root })
    users  = client.resource('users')

    it "returns a new Client object", ->
      expect(users).to.be.an.instanceof Client

    it "preconfigures the new path", ->
      expect(users.root).to.equal "#{root}/users"

describe 'Client integration', ->
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
