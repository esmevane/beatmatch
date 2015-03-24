global?.chai   = require('chai')
global?.expect = chai.expect

global?.lib = (filename) ->
  path = require('path')
  root = path.join(__dirname, '..')

  require path.join(root, 'lib', filename)
