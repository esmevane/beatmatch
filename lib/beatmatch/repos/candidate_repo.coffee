UserEntity = require('../entities/user_entity')

class CandidateRepo
  constructor: ->
    @candidates = {}

  set: ({ user, candidate }) -> @candidates[candidate] = user
  get: ({ candidate }) -> @candidates[candidate] || new UserEntity({})

global?.candidates = new CandidateRepo
module?.exports    = candidates
