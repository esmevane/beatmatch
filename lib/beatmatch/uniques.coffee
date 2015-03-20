_ = require('underscore')

class Uniques
  constructor: ({ @base, @other }) ->
  compare: -> _.uniq _.union @base, @other
  total: -> @compare().length

module?.exports = Uniques
