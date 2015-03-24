_          = require('underscore')
promise    = require('when')
RestClient = require('../utilities/rest_client')
Entity     = require('../entities/user_entity')

# Lots of this file is @wip for the sake of not pummeling the underlying API
# while I compose my components.

_get = (resource) ->
  url  = 'https://api.discogs.com/users'
  rest = new RestClient({ url, resource })
  rest.get()

_getWantlistIds = (name, done) ->
  done _.sample [1..100], 50
  # _get("#{name}/wants").then ({ entity }) ->
  #   ids = _.pluck entity.wants, 'id'
  #   done(ids)

_getCollectionIds = (name, done) ->
  done _.sample [1..100], 50
  # _get("#{name}/collection/folders/0/releases").then ({ entity }) ->
  #   ids = _.pluck entity.wants, 'id'
  #   done(ids)

class UserRepo
  constructor: -> @users = {}

  index: -> _.values @users

  show: (name) ->
    return @users[name] if @users[name]?
    @get name, (user) => @users[name] = user

  get: (name, done) ->
    user       = new Entity({ name })
    wantlist   = _getWantlistIds   name, (ids) -> user.wantlist = ids
    collection = _getCollectionIds name, (ids) -> user.collects = ids

    @users[name] ||= user

    done(user)
    # complete   = -> done(user)
    #
    # error = (message) ->
    #   user.loadError = reason: message
    #   done(user)
    #
    # promise.all([wantlist, collection]).then(complete, error)

global?.repo = new UserRepo
global?.users = repo.users

module?.exports = repo
