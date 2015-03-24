# # # Workflow
# # 1. Ask Store for user by name
# # 2. Store fetches user data with a repo
# # 3. Repo handles creating the user object with the client
# # 4. Store responds to callback with user object
# # 5. User has signals
# # 6. Signals are a collection object, wraps set math for comparisons
# # 7. Comparisons use resulting signal collections for index api
#
# Repo = lib 'beatmatch/repos/user_repo'
# User = lib 'beatmatch/entities/user_entity'
#
# describe 'Fetching users', ->
#   @timeout 3000
#
#   it "marshals a user entity", (done) ->
#     Repo.get 'anonexistantusername', (user) ->
#       expect(user).to.be.instanceof User
#       done()
