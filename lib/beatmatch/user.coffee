{ Client }      = require('disconnect')
{ Credentials } = require('../../config/credentials')

DiscogAPI = new Client
  consumerKey:    Credentials.consumerKey
  consumerSecret: Credentials.consumerSecret

class User
  constructor: ({ @name }) ->
    @collected     = DiscogAPI.user().collection()
    @list          = DiscogAPI.user().wantlist()
    @collectionIds = []
    @wantedIds     = []

  getWants: (done) ->
    @list.releases @name, (error, data) ->
      @wantedIds = data.wants.map (release) -> release.id
      done(error, data)

  getCollection: (done) ->
    @collected.releases @name, 0, (error, data) ->
      @collectionIds = data.releases.map (release) -> release.id
      done(error, data)

  collection: (done) ->
    return @collectionIds if @collectionIds.length
    @getCollection(done)
    @collectionIds

  wants: (done) ->
    return @wantedIds if @wantedIds.length
    @getWants(done)
    @wantedIds

module?.exports = User
