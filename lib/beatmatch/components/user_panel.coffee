React          = require 'react'
UserStore      = require '../stores/user_store'
CandidateStore = require '../stores/candidate_store'
Actions        = require '../actions/user_actions'

class Titles extends React.Component
  drawIds: -> @props.ids.map (id) -> <li key={ id }>{ id }</li>

  render: ->
    <ul className='titles'>
      { @drawIds() }
    </ul>

class Collection extends React.Component
  render: ->
    <section className='collection'>
      <Titles ids={ @props.ids } />
    </section>

class Wantlist extends React.Component
  render: ->
    <section className='wantlist'>
      <Titles ids={ @props.ids } />
    </section>

class UserPanel extends React.Component
  constructor: (properties) ->
    @state    = properties
    { @name } = properties
    super(properties)

  componentWillMount: ->
    CandidateStore.onChange =>
      @setState CandidateStore.getUser(@state)

  handleBlur: =>
    Actions.getUser(@state) unless @name is @state.name

  handleSubmit: (event) =>
    event.preventDefault()
    @handleBlur()

  handleChange: =>
    @setState name: @refs.name.getDOMNode().value

  render: ->
    <section className='user-panel'>
      <header className={ @state.candidate }>
        <form onSumbit={ @handleSubmit }>
          <input ref='name'
                 value={ @state.name }
                 placeholder='Enter a username'
                 onChange={ @handleChange }
                 onBlur= { @handleBlur } />
        </form>
      </header>
      <Collection ids={ @state.collects || [] }/>
      <Wantlist ids={ @state.wantlist || [] }/>
    </section>

module?.exports = UserPanel
