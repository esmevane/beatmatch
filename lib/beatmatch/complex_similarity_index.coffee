_ = require('underscore')

class ComplexSimilarityIndex
  constructor: (@indices...) ->

  uniques: ->
    _.uniq _.union _.flatten @indices.map (index) -> index.uniques.compare()

  similarities: ->
    similarities = @indices.map (index) -> index.similarities.total()
    reduction = (sum, total) -> sum + total
    _.reduce similarities, reduction, 0

  compare: ->
    parseFloat(@similarities()) / @uniques().length

module?.exports = ComplexSimilarityIndex
