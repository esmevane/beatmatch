Constants  = require('../constants/user_constants')
Dispatcher = require('../dispatchers/user_dispatcher')

class UserActions
  getUser: (payload) ->
    Dispatcher.handleViewAction
      type:    Constants.GetUser
      payload: payload

  setCandidate: (payload) ->
    Dispatcher.handleUserStoreAction
      type:    Constants.SetCandidate
      payload: payload

module?.exports = new UserActions
