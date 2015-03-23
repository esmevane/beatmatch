_      = require 'underscore'
Signal = require './signal'

class Signals
  constructor: ({ contents } = {}) ->
    @_contents = contents || []
    @length    = @_contents.length

  create: (key, value) ->
    newSignal = Signal.create(key, value)

    @_contents.push(newSignal)
    @length = @_contents.length

    newSignal

  fetch: (key) ->
    signal = _.find @_contents, (signal) -> signal.key() is key
    signal?.valueOf() || []

  members: -> @_contents.map (signal) -> signal.key()

  product: (other) ->
    product = []
    for signal in @toArray()
      for otherSignal in other.toArray()
        newSignal = new Signals(contents: [signal, otherSignal])
        product.push(newSignal) unless signal.sameKey(otherSignal)
    product

  values: -> @_contents.map (signal) -> signal.valueOf()

  subjects: ->
    iterator = (memo, value) -> memo.concat(value)
    values   = @_contents.map (signal) -> signal.valueOf()
    _.reduce values, iterator, []

  toArray: -> @_contents

Signals.create = (attributes) ->
  contents = new Signals
  for key, value of attributes
    contents.create(key, value) if _.isArray(value)
  contents

module?.exports = Signals
