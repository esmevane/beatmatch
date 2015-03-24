Dispatcher       = require('../dispatchers/user_dispatcher')
Actions          = require('../actions/user_actions')
Constants        = require('../constants/user_constants')
Repo             = require('../repos/user_repo')
{ EventEmitter } = require('events')

class UserStore extends EventEmitter
  hasChanged:           => @emit Constants.UsersChange
  onChange:  (callback) -> @on Constants.UsersChange, callback
  offChange: (callback) -> @removeListener Constants.UsersChange, callback

  showUser: (name) -> Repo.show(name)

  registry: ({ action }) =>
    { name } = action
    switch action.type
      when Constants.GetUser then Repo.get(name, @hasChanged)

userStore = new UserStore
userStore.dispatcherIndex = Dispatcher.register(userStore.registry)

module?.exports = userStore
