Signals         = lib 'matchmaker/signals'
SimilarityIndex = lib 'matchmaker/similarity_index'
Matchmaker      = lib 'matchmaker'

describe "Matchmaker", ->
  base =
    likes:    [1..10]
    dislikes: [11..20]
    wants:    [21..30]
    name:     "Frank"

  other =
    likes:    [5..15]
    dislikes: [1..3]
    wants:    [16..19]
    name:     "Joe"

  comparison = new Matchmaker({ base, other })

  describe '#compare', ->
    it "provides a comparison metric", ->
      expect(comparison.compare()).to.equal -0.2

  describe 'initialization', ->
    it "contains a signals collection for base", ->
      expect(comparison.base).to.be.instanceof Signals

    it "contains a signals collection for other", ->
      expect(comparison.other).to.be.instanceof Signals

    it 'contains a similarity index for the given signals', ->
      expect(comparison.index).to.be.instanceof SimilarityIndex
