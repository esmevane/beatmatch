Dispatcher = require('./base')
Constants  = require('../constants/user_constants')

class UserDispatcher extends Dispatcher
  handleViewAction: (payload) ->
    @dispatch source: Constants.ViewAction, action: payload

module?.exports = new UserDispatcher
