Signals         = require './matchmaker/signals'
SimilarityIndex = require './matchmaker/similarity_index'

class Matchmaker
  constructor: ({ base, other }) ->
    @base  = Signals.create(base)
    @other = Signals.create(other)
    @index = new SimilarityIndex({ @base, @other })

  compare: -> @index.compare()
  stats:   -> @index.stats()

module?.exports = Matchmaker
