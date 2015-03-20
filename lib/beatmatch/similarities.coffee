_ = require('underscore')

class Similarities
  constructor: ({ @base, @other }) ->
  compare: -> _.intersection @base, @other
  total: -> @compare().length

module?.exports = Similarities
