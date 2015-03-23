global?.chai  = require('chai')
global?.spies = require('chai-spies')

chai.use(spies)

global?.expect = chai.expect
global?.async  = require('async')

global?.lib = (filename) ->
  path = require('path')
  root = path.join(__dirname, '..')

  require path.join(root, 'lib', filename)
