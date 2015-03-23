Similarities = require './similarities'
Distinctions = require './distinctions'
Denominator  = require './denominator'

class SimilarityIndex
  constructor: ({ @base, @other }) ->
    @similarities = new Similarities({ @base, @other })
    @distinctions = new Distinctions({ @base, @other })
    @denominator  = new Denominator({ @base, @other })

  compare: ->
    similar  = parseFloat(@similarities.total())
    distinct = parseFloat(@distinctions.total())
    divisor  = parseFloat(@denominator.total())

    (similar - distinct) / divisor

module?.exports = SimilarityIndex
