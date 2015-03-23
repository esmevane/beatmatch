Signal  = lib 'beatmatch/signal'
Signals = lib 'beatmatch/signals'

describe "Signals", ->
  attributes =
    likes: [1..3]
    dislikes: [1..3]
    stuff: 'things'

  collection = new Signals(attributes)

  describe '#contents', ->
    it "is a list", ->
      expect(collection.contents()).to.be.instanceof Array

    it 'creates a list member for every array value', ->
      expect(collection.contents().length).to.eql 2

    it 'contains Signal instances', ->
      for signal in collection.contents()
        expect(signal).to.be.instanceof Signal
