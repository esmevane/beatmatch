_ = require 'underscore'

class Denominator
  constructor: ({ @base, @other }) ->

  set: -> _.uniq _.union @base.subjects(), @other.subjects()
  total: -> @set().length

module?.exports = Denominator
