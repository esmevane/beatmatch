Signals         = lib 'matchmaker/signals'
SimilarityIndex = lib 'matchmaker/similarity_index'

describe 'SimilarityIndex', ->
  it "produces a comparison metric", ->
    base       = Signals.create likes: [1..10]
    other      = Signals.create likes: [5..15]
    comparison = new SimilarityIndex({ base, other })

    expect(comparison.compare()).to.equal 0.4

  it "is 1.0 when given a perfect match", ->
    base       = Signals.create likes: [1..10]
    other      = Signals.create likes: [1..10]
    comparison = new SimilarityIndex({ base, other })

    expect(comparison.compare()).to.equal 1.0

  it "is 0 when given no matches", ->
    base       = Signals.create likes: [1..5]
    other      = Signals.create likes: [6..10]
    comparison = new SimilarityIndex({ base, other })

    expect(comparison.compare()).to.equal 0
