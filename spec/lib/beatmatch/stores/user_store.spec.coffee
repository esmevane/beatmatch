UserConstants = lib 'beatmatch/constants/user_constants'
UserStore     = lib 'beatmatch/stores/user_store'

describe 'UserStore', ->
  describe '#onChange', ->
    eventGiven      = null
    callbackGiven   = null
    anyCallbackEver = ->

    UserStore.on = (event, callback) ->
      [eventGiven, callbackGiven] = [event, callback]

    UserStore.onChange anyCallbackEver

    it "observes the UsersChange event", ->
      expect(eventGiven).to.eql UserConstants.UsersChange

    it "registers the given callback", ->
      expect(callbackGiven).to.eql anyCallbackEver

  describe '#offChange', ->
    eventGiven      = null
    callbackGiven   = null
    anyCallbackEver = ->

    UserStore.removeListener = (event, callback) ->
      [eventGiven, callbackGiven] = [event, callback]

    UserStore.offChange anyCallbackEver

    it "observes the UsersChange event", ->
      expect(eventGiven).to.eql UserConstants.UsersChange

    it "registers the given callback", ->
      expect(callbackGiven).to.eql anyCallbackEver

  describe '#hasChanged', ->
    it 'emits UserConstants.UserChanged', ->
      emittedConstant = null
      UserStore.emit  = (constant) -> emittedConstant = constant

      UserStore.hasChanged()

      expect(emittedConstant).to.eql UserConstants.UsersChange
