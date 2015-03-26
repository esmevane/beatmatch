_                = require 'underscore'
{ EventEmitter } = require('events')

class ScatterStore extends EventEmitter
  hasChanged:          => @emit 'chart:data:change',
  onChange: (callback) -> @on 'chart:data:change', callback
  getState:            -> @randomData()

  randomData: ->
    { domain: { low, high }, dots, seed } = Scatter.defaults

    domain = x: [low, high], y: [low, high], z: [low, high]
    data   = []

    for number in [1..dots]
      [ id, x, y, z ] = _.sample [1..seed], 4
      data.push { id, x, y, z }

    { domain, data }

global?.Scatter =
  defaults:
    domain:
      low: -5
      high: 25
    dots: 100
    seed: 20

scatterStore = new ScatterStore
setInterval scatterStore.hasChanged, 2500

module?.exports = scatterStore
