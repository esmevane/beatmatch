invariant = (condition, format, args...) ->
  unless condition
    errorMessage = if format is undefined
      """
        Minified exception occurred; use the non-minified dev environment
          for the full error message and additional helpful warnings.
      """

    else
      argIndex  = 0
      nextArg   = -> args[argIndex++]
      violation = format.replace(/%s/g, nextArg)

      """
        Invariant Violation:  #{violation}
      """

    error = new Error(errorMessage)
    error.framesToPop = 1
    throw error

module.exports = invariant
