class ListLike extends Countable
  constructor: (@values) ->

  length: -> @values.length

  part: (i) -> @values[i]

  fold: (zero,f) ->
    result = zero
    for a in @values
      result = f(result,a)
    return result

  toString: ->
    "("+@values.join(",")+")"
