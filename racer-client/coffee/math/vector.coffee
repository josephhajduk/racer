#**Vector** is a immutable vector representation
#it provides functions for most vector math operations
class Vector extends Countable
  #Creates a new immutable vector given an array of values
  constructor: (data, field) ->

    @field =
      name: "R"
      add: (a,b) -> a+b
      mult: (a,b) -> a*b
      iadd: (a) -> -a
      imult: (a) -> 1/a if a != 0
      zero: 0
      one: 1

    if field?
      @field = field


    #copy the array so that our vector can't be changed later
    _data = data[..]

    #we define the property explicitly so that we can guarantee immutability
    Object.defineProperty @, 'values',
      get: ->
        _data
      set: (val) ->

      enumerable: true
      configurable: true

    # this is the dimension of the Vector
    @dim = @values.length

    # we provide 4 convienient attributes to access the first 4 elements of the vector
    @x = @values[0]
    @y = @values[1]
    @z = @values[2]
    @t = @values[3]

  # we provide two static class methods to produce the x and y unit vectors
  @unitX: => lazy @,"unitX",->
    new Vector([1,0])

  @unitY: => lazy @,"unitY", ->
    new Vector([0,1])

  toString: -> lazy @,"toString", =>
    "Vector " + super

  # part returns the ith element of the vector
  part: (i) -> @values[i]

  norm: -> lazy @,"norm",=>
    Math.sqrt(@.dot @)

  normalize:-> lazy @,"normalize", =>
    new Vector(a / @norm() for a in @values)

  distance: (b) ->
    @.sub(b).norm()

  sum: -> lazy @,"sum", =>
    @fold(@field.zero, @field.add)

  multsum: -> lazy @,"multsum", =>
    @fold(@field.one, @field.mult)

  add: (b) ->
    if b.dim == @dim
      new Vector(@field.add(an,bn) for [an, bn] in zip(@values, b.values))

  sub: (b) ->
    @add(b.negative())

  multiply: (b) ->
    if b.dim?
      if b.dim == @dim
        new Vector(@field.mult(an,bn) for [an, bn] in zip(@values, b.values))

  entrywise_inverse: -> lazy @,"entrywise_inverse", =>
    if @values.indexOf(0) == -1
      new Vector(@field.imult(a) for a in @values)

  dot: (b) ->
    @multiply(b).sum()

  apply_transformation: (m) ->
    m.multiply(@)

  rotate: (theta, yaw, roll) ->
    if @dim == 2
      @apply_transformation(RotationMatrix2D.by(theta))
    else if @dim == 3
      @apply_transformation(RotationMatrix3D.by(theta, yaw, roll))

  # cos theta = a.b / (len of a * len ofv)
  vectorAngle: (b) ->
    if @field.mult(@.norm(),b.norm()) != 0
      Math.acos((@.dot b ) / ( @.norm() * b.norm()))

  #projection of a onto b
  projection: (b) ->
    c = @field.mult @.dot(b), @field.imult(b.dot(b))
    new Vector(@field.mult(c,bn) for bn in b.values)

  off: (b) ->
    new Vector(@field.add(a, @field.iadd(p) ) for [a, p] in zip(@values, @projection(b).values))

  cross: (b) ->
    if b.dim?
      if @dim == 3 and b.dim == 3
        new Matrix([
          [ 0, @field.iadd(@z), @y]
          [@z, 0, @field.iadd(@x)]
          [@field.iadd(@y), @x, 0]
        ]).multiply(b)

  negative: -> lazy @,"negative", =>
    @scale(@field.iadd(@field.one))

  scale: (c) ->
    new Vector(@for_each((x) => @field.mult(c,x)))

  addEach: (c) ->
    new Vector(@for_each((x) => @field.add(x,c)))

root = exports ? this
root.Vector = Vector





