SimilarityIndex = require '../../../lib/beatmatch/similarity_index'

describe 'SimilarityIndex', ->
  it "produces a comparison metric", ->
    base = [1..10]
    other = [5..15]
    comparison = new SimilarityIndex({ base, other })
    expect(comparison.compare()).to.be 0.4

  it "is 1.0 when given a perfect match", ->
    base = [1..10]
    other = [1..10]
    comparison = new SimilarityIndex({ base, other })
    expect(comparison.compare()).to.be 1.0

  it "is 0 when given no matches", ->
    base = [1..5]
    other = [6..10]
    comparison = new SimilarityIndex({ base, other })
    expect(comparison.compare()).to.be 0
