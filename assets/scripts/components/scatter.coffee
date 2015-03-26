React        = require('react')
Canvas       = require('../visuals/canvas')
ScatterStore = require('../stores/scatter_store')

class Scatter extends React.Component
  constructor: (properties) ->
    @state = ScatterStore.getState()
    super(properties)

  componentWillMount: ->
    ScatterStore.onChange => @setState ScatterStore.getState()

  componentDidMount: ->
    @chart = new Canvas(@refs.container.getDOMNode())
    @chart.create(@state)

  componentWillUpdate: -> @chart.update(@state)
  componentWillUnmount: -> @chart.destroy()

  render: -> <section ref='container' className='chart-container' />

Scatter.propTypes =
  domain: React.PropTypes.object
  data:   React.PropTypes.array

module?.exports = Scatter
