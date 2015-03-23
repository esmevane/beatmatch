_ = require 'underscore'

class Distinctions
  constructor: ({ @base, @other }) ->

  set: ->
    sets = []
    for signals in @base.product(@other)
      sets = sets.concat _.intersection(signals.values()...)
    sets

  total: -> @set().length

module?.exports = Distinctions
