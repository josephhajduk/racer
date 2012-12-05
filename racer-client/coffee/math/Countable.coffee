class Countable
  constructor: (@values)->

  for_each: (f) -> f(@part(i)) for i in [0...@length()]

  length: -> @values.length

  part: (i) -> @values[i]

  fold: (zero,f) ->
    result = zero
    for a in [0...@length()]
      result = f(result,@part(a))
    return result

  toString: ->
    "("+@values.join(",")+")"
