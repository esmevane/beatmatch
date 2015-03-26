express  = require 'express'
app      = express()
UserRepo = require './lib/beatmatch/repos/user_repo'

routeToFile = ({ app, route, file }) ->
  app.get route, (request, response, next) -> response.sendfile file

app.use '/fonts',   express.static "app/fonts"
app.use '/images',  express.static "app/images"
app.use '/scripts', express.static "app/scripts"
app.use '/styles',  express.static "app/styles"

app.get '/users/:name', (request, response) ->
  { params: { name } } = request
  UserRepo.get name, (user) -> response.json 200, user

routeToFile app: app, route: '*', file: 'app/index.html'

module.exports = app
