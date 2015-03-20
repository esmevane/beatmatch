Similarities = require '../../../lib/beatmatch/similarities'

describe 'Similarities', ->
  base = [1..10]
  other = [6..15]
  comparison = new Similarities({ base, other })

  it "produces the similar items", ->
    expect(comparison.compare()).to.eql [6..10]

  it "gives a total", ->
    expect(comparison.total()).to.eql [6..10].length
