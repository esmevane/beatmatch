UserActions   = lib 'beatmatch/actions/user_actions'
UserConstants = lib 'beatmatch/constants/user_constants'

mockDispatcher   = type: null, name: null
UserActions.view = (options) -> mockDispatcher = options

describe 'UserActions', ->
  describe '#getUser', ->
    UserActions.getUser('name')

    it "sets the type to UserConstants.GetUser", ->
      expect(mockDispatcher.type).to.eql UserConstants.GetUser

    it "passes the name given", ->
      expect(mockDispatcher.name).to.eql 'name'
