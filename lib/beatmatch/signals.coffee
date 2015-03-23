_      = require 'underscore'
Signal = require './signal'

class Signals
  constructor: (attributes) ->
    @_contents = []
    for key, value of attributes
      @_contents.push(Signal.create(key, value)) if _.isArray(value)

  contents: -> @_contents

module?.exports = Signals
