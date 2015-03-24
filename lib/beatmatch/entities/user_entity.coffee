class UserEntity
  constructor: ({ @name, @wantlist, @collects }) ->
    @wantlist ?= []
    @collects ?= []

module?.exports = UserEntity
