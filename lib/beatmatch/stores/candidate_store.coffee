UserStore        = require('./user_store')
Dispatcher       = require('../dispatchers/user_dispatcher')
Actions          = require('../actions/user_actions')
Constants        = require('../constants/user_constants')
CandidateRepo    = require('../repos/candidate_repo')
{ EventEmitter } = require('events')

class CandidateStore extends EventEmitter
  hasChanged: (payload) => @emit Constants.CandidatesChange, payload
  onChange:  (callback) -> @on Constants.CandidatesChange, callback
  offChange: (callback) -> @removeListener Constants.CandidatesChange, callback

  getUser: ({ candidate }) -> CandidateRepo.get({ candidate })
  setUser: ({ user, candidate }) =>
    CandidateRepo.set({ user, candidate })
    @hasChanged({ user, candidate })

  registry: ({ action }) =>
    { user, type, candidate } = action
    switch type
      when Constants.SetCandidate then CandidateRepo.set({ user, candidate })

candidateStore = new CandidateStore
candidateStore.dispatcherIndex = Dispatcher.register(candidateStore.registry)

UserStore.onChange candidateStore.setUser

module?.exports = candidateStore
