Signal = lib 'matchmaker/signal'

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
