_          = require('underscore')
promise    = require('when')
RestClient = require('../utilities/rest_client')
Entity     = require('../entities/user_entity')

_get = (resource) ->
  url  = 'https://api.discogs.com/users'
  rest = new RestClient({ url, resource })
  rest.get()

_getWantlist = (name, done) ->
  _get("#{name}/wants").then ({ entity }) ->
    ids   = _.pluck entity.wants, 'id'
    wants = entity.wants

    done({ ids, wants })

_getCollection = (name, done) ->
  _get("#{name}/collection/folders/0/releases").then ({ entity }) ->
    ids      = _.pluck entity.releases, 'id'
    collects = entity.releases

    done({ ids, collects })

_getLocalUser = (name, done) ->
  url      = ''
  resource = "users/#{name}"
  rest     = new RestClient({ url, resource })
  rest.get().then ({ entity }) ->
    console.log entity
    done(entity)

class UserRepo
  constructor: -> @users = {}
  index: -> _.values @users

  get: (name, done) ->
    user     = new Entity({ name })
    promises = []

    complete = ->
      @users[name] = user

      done(user)

    error = (message) ->
      user.loadError = reason: message
      @users[name]   = user

      done(user)

    if process.browser
      request = _getLocalUser name, (response) -> user.update(response)

      promises.push(request)
    else
      wantlist = _getWantlist name, ({ ids, wants }) ->
        user.update(wantlist: ids, detail: wants: wants)

      collection = _getCollection name, ({ ids, collects }) ->
        user.update(collects: ids, detail: collects: collects)

      promises.push wantlist, collection

    promise.all(promises).then(complete, error)

global?.repo    = new UserRepo
global?.users   = repo.users

module?.exports = repo
