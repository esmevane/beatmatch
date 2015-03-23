_ = require 'underscore'

class Distinctions
  constructor: ({ @base, @other }) ->

  set: ->
    sets = []
    for [baseKey, otherKey] in @_product()
      sets = sets.concat _.intersection @base[baseKey], @other[otherKey]
    sets

  total: -> @set().length

  _baseKeys: ->
    baseKeys  = []
    for key, value of @base
      baseKeys.push(key) if _.isArray(value)
    baseKeys

  _otherKeys: ->
    otherKeys = []
    for key, value of @other
      otherKeys.push(key) if _.isArray(value)
    otherKeys

  _product: ->
    product = []
    for baseKey in @_baseKeys()
      for otherKey in @_otherKeys()
        product.push([baseKey, otherKey]) unless baseKey is otherKey
    product

module?.exports = Distinctions
