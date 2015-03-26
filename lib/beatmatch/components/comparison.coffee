React          = require 'react'
CandidateStore = require '../stores/candidate_store'
Actions        = require '../actions/user_actions'
Matchmaker     = require '../../../lib/matchmaker'

class Comparison extends React.Component
  constructor: (properties) ->
    @state = properties
    super(properties)

  componentWillMount: ->
    CandidateStore.onChange =>
      @setState
        base:  CandidateStore.getUser(candidate: 'base')
        other: CandidateStore.getUser(candidate: 'other')

  compare: ->
    return '' unless @_ready()
    comparison = new Matchmaker(@state)
    comparison.compare()

  _ready: -> @state.base?.name? and @state.other?.name?

  warmth: ->
    return 'bad-match'     if @compare() < 0.0
    return 'neutral-match' if @compare() is 0.0
    return 'good-match'    if @compare() > 0.0
    'no-match'

  className: -> "comparison #{@warmth()}"

  percentage: ->
    result = @compare()
    result = parseInt result * 100
    result = if result.toString() is "NaN" then 0 else result
    "#{result}%"

  render: ->
    <figure className={ @className() }>
      <figcaption>{ @percentage() }</figcaption>
    </figure>

module?.exports = Comparison
