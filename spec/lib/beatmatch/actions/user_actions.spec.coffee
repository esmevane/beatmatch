UserActions   = lib 'beatmatch/actions/user_actions'
UserConstants = lib 'beatmatch/constants/user_constants'

mockDispatcher   = type: null, payload: null
UserActions.view = (options) -> mockDispatcher = options

describe 'UserActions', ->
  describe '#getUser', ->
    payload = name: 'name', candidate: 'base'
    UserActions.getUser(payload)

    it "sets the type to UserConstants.GetUser", ->
      expect(mockDispatcher.type).to.eql UserConstants.GetUser

    it "passes the name given", ->
      expect(mockDispatcher.payload).to.eql payload
