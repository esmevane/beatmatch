Similarities = require './similarities'
Distinctions = require './distinctions'
Denominator  = require './denominator'

class SimilarityIndex
  constructor: ({ @base, @other }) ->
    @similarities = new Similarities({ @base, @other })
    @distinctions = new Distinctions({ @base, @other })
    @denominator  = new Denominator({ @base, @other })

  stats: ->
    similarities:
      set:   @similarities.set()
      total: @similarities.total()
    distinctions:
      set:   @distinctions.set()
      total: @distinctions.total()
    subjects:
      set:   @denominator.set()
      total: @denominator.total()

  compare: ->
    similar  = parseFloat(@similarities.total())
    distinct = parseFloat(@distinctions.total())
    divisor  = parseFloat(@denominator.total())

    (similar - distinct) / divisor

module?.exports = SimilarityIndex
