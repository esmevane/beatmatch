# Sojourn makes the following libraries available on demand.  Simply uncomment
# these lines to use in a bootstrap method, or, if you require them in other
# components, add the requirements there.
#
# $        = require 'jquery'
# _        = require 'underscore'
# Backbone = require 'backbone'

React      = require 'react'
UserPanel  = require '../lib/beatmatch/components/user_panel'
Comparison = require '../lib/beatmatch/components/comparison'
element    = document.getElementById('beatmatch-panel')

class App extends React.Component
  render: ->
    <section className='app-container'>
      <Comparison />
      <UserPanel candidate='base' />
      <UserPanel candidate='other' />
    </section>

React.render <App />, element
