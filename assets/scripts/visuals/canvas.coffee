d3      = require('d3')
Scatter = require('./scatter')

texture = textures.lines().size(4)
            .strokeWidth(1).stroke('rgba(64, 60, 60, 0.3)')

class Canvas
  defaults: ->
    class:  'dot-chart'
    height: @element.parentNode.offsetHeight
    width:  @element.parentNode.offsetWidth

  constructor: (@element) ->
    @contents  = d3.select(@element).append('svg').attr(@defaults())
    @container = @contents.append('g').attr('class', 'dot-container')
    @scatter   = new Scatter({ @container, texture })

    @contents.call(texture)

  create: ({ domain, data }) ->
    options = domain: domain, data: data, boundaries: @boundaries({ domain })
    @scatter.entrance(options)

  update: ({ domain, data }) ->
    options = domain: domain, data: data, boundaries: @boundaries({ domain })
    @scatter.update(options)

  destroy: ({ domain, data }) -> @scatter.exit({ domain, data })

  boundaries: ({ domain }) ->
    { height, width } = @defaults()

    x = d3.scale.linear().range([ 0, width ]).domain(domain.x)
    y = d3.scale.linear().range([ 0, height ]).domain(domain.y)
    z = d3.scale.linear().range([ 5, 20 ]).domain([1, 10])

    { x, y, z }

module?.exports = Canvas
