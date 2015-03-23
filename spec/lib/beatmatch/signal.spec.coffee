# # Workflow (How to yerp the nert)
# 1. Ask Store for user by name
# 2. Store fetches user data with a repo
# 3. Repo handles creating the user object with the client
# 4. Store responds to callback with user object
# 5. User has signals
# 6. Signals are a collection object, wraps set math for comparisons
# 7. Comparisons use resulting signal collections for index api

Signal = lib 'beatmatch/signal'

describe "Signal", ->
  signal = Signal.create('likes', [1..3])

  describe '#sameKey', ->
    describe 'when it matches', ->
      it "is true", -> expect(signal.sameKey(signal)).to.be.true

    describe 'otherwise', ->
      it "is false", ->
        other = Signal.create('dislikes', [1..3])
        expect(signal.sameKey(other)).to.be.false

  describe '#valueOf', ->
    it "equals the value given", ->
      expect(signal.valueOf()).to.eql [1..3]

  describe '#key', ->
    it "equals the key given", ->
      expect(signal.key()).to.eql 'likes'
