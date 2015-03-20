Similarities = require './similarities'
Uniques      = require './uniques'

class SimilarityIndex
  constructor: ({ @base, @other }) ->
    @similarities = new Similarities({ @base, @other })
    @uniques      = new Uniques({ @base, @other })

  compare: ->
    parseFloat(@similarities.total()) / @uniques.total()

module?.exports = SimilarityIndex
