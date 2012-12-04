class Countable
  constructor: ->
    #requires length() and part(i) are defined
  for_each: (f) -> f(@part(i)) for i in [0...@length()]
