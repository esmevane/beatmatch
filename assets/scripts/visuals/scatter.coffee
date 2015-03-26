class Scatter
  constructor: ({ @container, @texture }) -> @fill = @texture.url()

  entrance: ({ domain, data, boundaries }) ->
    dots = @container.selectAll('.dot').data data, ({ id }) -> id

    dots.enter().append('circle').attr(r: 0, class: 'dot', fill: @fill)

    @update({ domain, data, boundaries })

  update: ({ domain, data, boundaries }) ->
    dots = @container.selectAll('.dot').data data, ({ id }) -> id
    atts =
      cy: (dimension) -> boundaries.y(dimension.y)
      cx: (dimension) -> boundaries.x(dimension.x)
      r:  (dimension) -> boundaries.z(dimension.z)
      fill: @fill

    dots.enter().append('circle').attr('class', 'dot')
    dots.transition().duration(3000).attr(atts)

  exit: ({ domain, data }) ->
    dots = @container.selectAll('.dot').data data, ({ id }) -> id
    dots.exit().remove()

module?.exports = Scatter
