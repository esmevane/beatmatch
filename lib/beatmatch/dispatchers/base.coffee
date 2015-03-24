invariant = require('../utilities/invariant')

_lastID = 1
_prefix = 'ID_'

class Dispatcher
  constructor: ->
    @_callbacks = {}
    @_isPending = {}
    @_isHandled = {}
    @_isDispatching = false
    @_pendingPayload = null

  register: (callback) ->
    id = _prefix + _lastID++
    @_callbacks[id] = callback
    id

  unregister: (id) ->
    message = """
      Dispatcher.unregister(...): `%s` does not map to a registered callback.
    """

    invariant(@_callbacks[id], message, id)
    delete @_callbacks[id]

  waitFor: (ids) ->
    message = """
      Dispatcher.waitFor(...): Must be invoked while dispatching.
    """

    invariant(@_isDispatching, message)

    for id in ids
      if @_isPending[id]
        message = """
          Dispatcher.waitFor(...): Circular dependency detected while waiting
            for `%s`.
        """

        invariant(@_isHandled[id], message, id)

      message = """
        Dispatcher.waitFor(...): `%s` does not map to a registered callback.
      """

      invariant(@_callbacks[id], message, id)

      @_invokeCallback(id)

  dispatch: (payload) ->
    message = """
      Dispatch.dispatch(...): Cannot dispatch in the middle of a dispatch.
    """

    invariant(!@_isDispatching, message)

    @_startDispatching(payload)

    try
      for id of @_callbacks
        if @_isPending[id] then continue
        @_invokeCallback(id)
    finally
      @_stopDispatching()

  isDispatching: -> @_isDispatching

  _invokeCallback: (id) ->
    @_isPending[id] = true
    @_callbacks[id](@_pendingPayload)
    @_isHandled[id] = true

  _startDispatching: (payload) ->
    for id of @_callbacks
      @_isPending[id] = false
      @_isHandled[id] = false
    @_pendingPayload = payload
    @_isDispatching = true

  _stopDispatching: ->
    @_pendingPayload = null
    @_isDispatching = false

module.exports = Dispatcher
