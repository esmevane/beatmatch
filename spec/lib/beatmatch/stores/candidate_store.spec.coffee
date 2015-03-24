Constants      = lib 'beatmatch/constants/user_constants'
CandidateStore = lib 'beatmatch/stores/candidate_store'

describe 'CandidateStore', ->
  describe '#onChange', ->
    eventGiven      = null
    callbackGiven   = null
    anyCallbackEver = ->

    CandidateStore.on = (event, callback) ->
      [eventGiven, callbackGiven] = [event, callback]

    CandidateStore.onChange anyCallbackEver

    it "observes the UsersChange event", ->
      expect(eventGiven).to.eql Constants.CandidatesChange

    it "registers the given callback", ->
      expect(callbackGiven).to.eql anyCallbackEver

  describe '#offChange', ->
    eventGiven      = null
    callbackGiven   = null
    anyCallbackEver = ->

    CandidateStore.removeListener = (event, callback) ->
      [eventGiven, callbackGiven] = [event, callback]

    CandidateStore.offChange anyCallbackEver

    it "observes the UsersChange event", ->
      expect(eventGiven).to.eql Constants.CandidatesChange

    it "registers the given callback", ->
      expect(callbackGiven).to.eql anyCallbackEver

  describe '#hasChanged', ->
    it 'emits Constants.UserChanged', ->
      emittedConstant = null
      CandidateStore.emit  = (constant) -> emittedConstant = constant

      CandidateStore.hasChanged()

      expect(emittedConstant).to.eql Constants.CandidatesChange
