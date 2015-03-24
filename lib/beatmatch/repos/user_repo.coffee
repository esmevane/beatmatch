_          = require('underscore')
promise    = require('when')
RestClient = require('../utilities/rest_client')
Entity     = require('../entities/user_entity')

_get = (resource) ->
  url  = 'https://api.discogs.com/users'
  rest = new RestClient({ url, resource })
  rest.get()

_getWantlistIds = (name, done) ->
  _get("#{name}/wants").then ({ entity }) ->
    ids = _.pluck entity.wants, 'id'
    done(ids)

_getCollectionIds = (name, done) ->
  _get("#{name}/collection/folders/0/releases").then ({ entity }) ->
    ids = _.pluck entity.wants, 'id'
    done(ids)

class UserRepo
  constructor: -> @users = {}

  show: (name) ->
    return @users[name] if @users[name]?
    @get name, (user) => @users[name] = user

  get: (name, done) ->
    user       = new Entity({ name })
    wantlist   = _getWantlistIds   name, (ids) -> user.wantlist = ids
    collection = _getCollectionIds name, (ids) -> user.collects = ids
    complete   = -> done(user)

    error = (message) ->
      user.loadError = reason: message
      done(user)

    promise.all([wantlist, collection]).then(complete, error)

module?.exports = new UserRepo
