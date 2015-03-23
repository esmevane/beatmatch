Signals     = lib 'beatmatch/signals'
Denominator = lib 'beatmatch/denominator'

describe "Denominator", ->
  base = Signals.create
    likes: [1..3]
    dislikes: [4..6]
    wants: [7..9]

  other = Signals.create
    likes: [4..6]
    dislikes: [7..9]
    wants: [1..3]

  comparison = new Denominator({ base, other })

  describe '#set', ->
    it "contains the unique union of all array elements", ->
      expect(comparison.set()).to.eql [1..9]

  describe '#total', ->
    it "is the length of the unique union of all array elements", ->
      expect(comparison.total()).to.eql 9
