Dispatcher       = require('../dispatchers/user_dispatcher')
Actions          = require('../actions/user_actions')
Constants        = require('../constants/user_constants')
Repo             = require('../repos/user_repo')
{ EventEmitter } = require('events')

class UserStore extends EventEmitter
  hasChanged: (payload) => @emit Constants.UsersChange, payload
  onChange:  (callback) -> @on Constants.UsersChange, callback
  offChange: (callback) -> @removeListener Constants.UsersChange, callback

  showUser: ({ name, candidate }) -> Repo.show(name)

  registry: ({ action }) =>
    { type, payload: { name, candidate } } = action
    switch action.type
      when Constants.GetUser
        Repo.get name, (user) => @hasChanged({ user, candidate })

userStore = new UserStore
userStore.dispatcherIndex = Dispatcher.register(userStore.registry)

module?.exports = userStore
