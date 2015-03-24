UserEntity = require('../entities/user_entity')

class CandidateRepo
  constructor: ->
    @candidates = {}

  set: ({ user, candidate }) -> @candidates[candidate] = user
  get: ({ candidate }) -> @candidates[candidate] || new UserEntity({})

module?.exports = new CandidateRepo
