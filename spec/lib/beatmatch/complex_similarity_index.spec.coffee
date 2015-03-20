SimilarityIndex = require '../../../lib/beatmatch/similarity_index'
ComplexSimilarityIndex = require '../../../lib/beatmatch/complex_similarity_index'

describe 'ComplexSimilarityIndex', ->
  it "produces 0 (no match) when given no matching indexes", ->
    collections = new SimilarityIndex(base: [1..6], other: [7..12])
    wantlists   = new SimilarityIndex(base: [13..18], other: [19..25])
    comparison  = new ComplexSimilarityIndex(collections, wantlists)

    expect(comparison.compare()).to.be 0

  it "produces 1 (perfect match) on an exact match", ->
    collections = new SimilarityIndex(base: [1..6], other: [1..6])
    wantlists   = new SimilarityIndex(base: [7..25], other: [7..25])
    comparison  = new ComplexSimilarityIndex(collections, wantlists)

    expect(comparison.compare()).to.be 1

  it "produces 1 (great match) when given complimentary indexes", ->
    collections = new SimilarityIndex(base: [1..2], other: [1..6])
    wantlists   = new SimilarityIndex(base: [3..12], other: [7..25])
    comparison  = new ComplexSimilarityIndex(collections, wantlists)

    expect(comparison.compare()).to.be 0.32
