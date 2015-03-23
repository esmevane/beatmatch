_ = require 'underscore'

class Signal
  constructor: (attributes) ->
    @_key   = _.first Object.keys(attributes)
    @_value = attributes[@_key]

  key:     -> @_key
  valueOf: -> @_value

Signal.create = (key, value) ->
  object      = {}
  object[key] = value

  new Signal(object)

module?.exports = Signal
