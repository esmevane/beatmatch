SimilarityIndex = lib 'beatmatch/similarity_index'

describe 'SimilarityIndex', ->
  it "produces a comparison metric", ->
    base       = likes: [1..10]
    other      = likes: [5..15]
    comparison = new SimilarityIndex({ base, other })

    expect(comparison.compare()).to.equal 0.4

  it "is 1.0 when given a perfect match", ->
    base       = likes: [1..10]
    other      = likes: [1..10]
    comparison = new SimilarityIndex({ base, other })

    expect(comparison.compare()).to.equal 1.0

  it "is 0 when given no matches", ->
    base       = likes: [1..5]
    other      = likes: [6..10]
    comparison = new SimilarityIndex({ base, other })

    expect(comparison.compare()).to.equal 0
