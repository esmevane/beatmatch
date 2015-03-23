_       = require 'underscore'
Signal  = lib 'beatmatch/signal'
Signals = lib 'beatmatch/signals'

describe "Signals", ->
  attributes =
    likes: [1..3]
    dislikes: [1..3]
    stuff: 'things'

  collection = Signals.create(attributes)

  describe '#fetch', ->
    expect(collection.fetch('likes')).to.eql [1..3]

  describe '#members', ->
    it "is a flat list of all signal keys", ->
      expectation = [ 'likes', 'dislikes' ]
      expect(collection.members()).to.eql expectation

  describe '#subjects', ->
    it "is a flat list of all signal values", ->
      expectation = attributes.likes.concat attributes.dislikes
      expect(collection.subjects()).to.eql expectation

  describe '#toArray', ->
    it 'creates a list member for every array value', ->
      expect(collection.toArray().length).to.eql 2

    it 'contains Signal instances', ->
      for signal in collection.toArray()
        expect(signal).to.be.instanceof Signal

  describe '#product', ->
    it "is a product of all possible non-matched Signal combinations", ->
    it "contains a list of Signals collections", ->
      for signals in collection.product(collection)
        expect(signals).to.be.instanceof Signals

  describe '#values', ->
    it "is a flat list of all signal values", ->
      expectation = [ attributes.likes, attributes.dislikes ]
      expect(collection.values()).to.eql expectation
