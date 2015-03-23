_ = require 'underscore'

class Denominator
  constructor: ({ @base, @other }) ->

  set: -> _.uniq _.union @_baseValues(), @_otherValues()
  total: -> @set().length

  _baseValues:  -> @_valuesFrom(@base)
  _otherValues: -> @_valuesFrom(@other)

  _valuesFrom: (object) ->
    values = []
    for key, value of object
      values = values.concat(value) if _.isArray(value)
    values

module?.exports = Denominator
