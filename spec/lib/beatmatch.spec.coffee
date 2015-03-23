# describe 'Comparing users', ->
#   @timeout 500000
#
#   it "can compare with the basic toolkit", (done) ->
#     base       = new User name: 'jondavey'
#     other      = new User name: 'prophetk'
#     comparison = null
#
#     compare = (done) ->
#       collections = new SimilarityIndex
#         base:  base.collection()
#         other: other.collection()
#
#       wants = new SimilarityIndex
#         base:  base.wants()
#         other: other.wants()
#
#       comparison = new ComplexSimilarityIndex(collections, wants)
#       done()
#
#     sequences = [
#       (done) -> base.collection(done)
#       (done) -> base.wants(done)
#       (done) -> other.collection(done)
#       (done) -> other.wants(done)
#       compare
#     ]
#
#     async.series sequences, done
