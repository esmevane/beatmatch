React          = require 'react'
UserStore      = require '../stores/user_store'
CandidateStore = require '../stores/candidate_store'
Actions        = require '../actions/user_actions'

class TitleSummaries
  constructor: (titles) ->
    @contents = titles.map(@summarize)

  map: (callback) -> @contents.map(callback)

  summarize: ({ basic_information }) ->
    { id, title, thumb } = basic_information
    artists = basic_information.artists.map ({ name }) -> name
    formats = basic_information.formats.map ({ name }) -> name

    { id, title, thumb, artists, formats }

global?.titles = null

class Titles extends React.Component
  drawItems: ->
    summaries = new TitleSummaries(@props.details)

    global?.titles = summaries

    summaries.map ({ id, title, thumb, artists, formats }) ->
      <li className='title' key={ id }>
        <section>
          <header>
            { title } by { artists.join(", ") }
          </header>
          <section>
            <a href='http://discogs.com' target='_blank'>
              <div className='thumb'
                   style={ backgroundImage: "url('#{thumb}')" } />
              Available in { formats.join(", ") }
            </a>
          </section>
        </section>
      </li>

  render: ->
    <ul className='titles'> { @drawItems() } </ul>

class Collection extends React.Component
  render: ->
    <section className='collection'>
      { <h2>Collection</h2> if @props.details.length }
      <Titles details={ @props.details } />
    </section>

class Wantlist extends React.Component
  render: ->
    <section className='wantlist'>
      { <h2>Wantlist</h2> if @props.details.length }
      <Titles details={ @props.details } />
    </section>

class Feedback extends React.Component
  hasError:  -> !!@contents()
  contents:  -> @props?.error?.reason?.error?.code
  isPending: -> !@props?.name? and !@contents()

  errorClass: ->
    switch
      when @hasError() then 'error'
      when @isPending() then 'pending'
      else 'no-error'

  message: ->
    switch
      when @hasError() then @_errorMessage()
      when @isPending() then @_promptMessage()
      else ''

  render: ->
    <div className={ @errorClass() }>
      { @message() }
    </div>

  _errorMessage: ->
    <div className='message'>
      <p>
        <em> Unable to load { @props.name }! Details: </em>
        <strong> { @contents() || "Unknown" } </strong>
      </p>
      <p> Give it a bit, and try again. </p>
    </div>

  _promptMessage: ->
    <div className='prompt'>
      Input a <a href='http://discogs.com' target='_blank'>
        discogs username
      </a> to begin
    </div>

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
      <Feedback name={ @state.name } error={ @state.loadError } />
      <Collection details={ @state.detail?.collects || [] }/>
      <Wantlist details={ @state.detail?.wants || [] }/>
    </section>

module?.exports = UserPanel
