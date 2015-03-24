Constants  = require('../constants/user_constants')
Dispatcher = require('../dispatchers/user_dispatcher')

class UserActions
  view:    (options) -> Dispatcher.handleViewAction(options)
  getUser:    (name) -> @view type: Constants.GetUser, name: name

module?.exports = new UserActions
