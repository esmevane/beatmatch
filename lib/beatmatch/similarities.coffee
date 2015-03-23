_ = require 'underscore'

class Similarities
  constructor: ({ @base, @other }) ->

  set: ->
    set = []
    for key in @base.members()
      subjects = [ @base.fetch(key), @other.fetch(key) ]
      set      = set.concat _.intersection subjects...
    set

  total: -> @set().length

module?.exports = Similarities
