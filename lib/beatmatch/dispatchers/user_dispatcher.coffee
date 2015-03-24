Dispatcher = require('./base')
Constants  = require('../constants/user_constants')

class UserDispatcher extends Dispatcher
  handleUserStoreAction: (action) ->
    @dispatch source: Constants.UserStore, action: action

  handleViewAction: (action) ->
    @dispatch source: Constants.ViewAction, action: action

module?.exports = new UserDispatcher
