UserConstants  = lib 'beatmatch/constants/user_constants'
UserDispatcher = lib 'beatmatch/dispatchers/user_dispatcher'

mockDispatcher          = source: null, action: null
UserDispatcher.dispatch = (payload) -> mockDispatcher = payload

describe 'UserDispatcher', ->
  describe '#handleViewAction', ->

    payload = name: 'exnihilo'
    UserDispatcher.handleViewAction(payload)

    it "sets the type to UserConstants.ViewAction", ->
      expect(mockDispatcher.source).to.eql UserConstants.ViewAction

    it "passes the name given", ->
      expect(mockDispatcher.action).to.eql payload
