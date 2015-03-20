class Client
  constructor: ({ @key, @secret, @root }) ->
  resource: (resource) ->
    root = "#{@root}/#{resource}"
    new Client({ @key, @secret, root })

describe 'Client', ->
  describe 'initialization', ->
    it "accepts consumer keys", ->
      key    = 12345
      client = new Client({ key })

      expect(client.key).to.be key

    it "accepts consumer secrets", ->
      secret = 67890
      client = new Client({ secret })

      expect(client.secret).to.be secret

    it "accepts a resource root", ->
      root   = "http://test.host"
      client = new Client({ root })

      expect(client.root).to.be root

  describe '#resource', ->
    root   = "http://test.host"
    client = new Client({ root })
    users  = client.resource('users')

    it "returns a new Client object", ->
      expect(users).to.be.a Client

    it "preconfigures the new path", ->
      expect(users.root).to.be "#{root}/users"
