# Sojourn makes the following libraries available on demand.  Simply uncomment
# these lines to use in a bootstrap method, or, if you require them in other
# components, add the requirements there.
#

React      = require 'react'
UserPanel  = require '../lib/beatmatch/components/user_panel'
Comparison = require '../lib/beatmatch/components/comparison'
Scatter    = require './components/scatter'

class App extends React.Component
  render: ->
    <main>
      <section id='headline'>
        <Scatter />
        <div className='logo' />
      </section>
      <section id='beatmatch-panel'>
        <section className='app-container'>
          <Comparison />
          <UserPanel candidate='base' />
          <UserPanel candidate='other' />
        </section>
      </section>
    </main>

React.render <App />, document.body
