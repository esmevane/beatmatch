_ = require 'underscore'

class Commonalities
  constructor: ({ @base, @other }) ->

  set: ->
    set = []
    for key in @_keys()
      set = set.concat _.intersection @base[key], (@other[key] or [])
    set

  total: -> @set().length

  _keys: ->
    keys = []
    for key, value of @base
      keys.push(key) if _.isArray(value)
    keys

module?.exports = Commonalities
