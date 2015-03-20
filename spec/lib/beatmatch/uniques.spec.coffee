Uniques = require '../../../lib/beatmatch/uniques'

describe 'Uniques', ->
  base = [1..10]
  other = [6..15]
  comparison = new Uniques({ base, other })

  it "produces the distinct items", ->
    expect(comparison.compare()).to.eql [1..15]

  it "gives a total", ->
    expect(comparison.total()).to.eql [1..15].length
