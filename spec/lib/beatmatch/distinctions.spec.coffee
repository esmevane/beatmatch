Distinctions = lib 'beatmatch/distinctions'

describe "Distinctions", ->
  base =
    likes: [1..3]
    dislikes: [4..6]
    wants: [7..9]

  other =
    likes: [4..6]
    dislikes: [7..9]
    wants: [1..3]

  comparison = new Distinctions({ base, other })

  describe '#set', ->
    it "contains the product of compared sets", ->
      expect(comparison.set()).to.eql [1..9]

  describe '#total', ->
    it "is the total number of set members", ->
      expect(comparison.total()).to.eql 9
