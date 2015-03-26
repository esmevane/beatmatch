class UserEntity
  constructor: ({ @name, @wantlist, @collects, @detail, @loadError }) ->
    @wantlist ?= []
    @collects ?= []

  update: ({ name, wantlist, collects, detail, loadError }) ->
    @wantlist = wantlist if wantlist
    @name     = name     if name
    @collects = collects if collects

    @detail ?= {}
    @detail[key] = value for key, value of detail

    @loadError = loadError

module?.exports = UserEntity
