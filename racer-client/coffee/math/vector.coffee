class Vector extends ListLike
  constructor: (@values) ->
    @dim = @values.length

    @x = @values[0]
    @y = @values[1]
    @z = @values[2]
    @t = @values[3]

  toString: ->
    "Vector " + super

  part: (i) -> @values[i]

  norm: -> Math.sqrt(@.dot @)

  normalize: ->
    new Vector(a / @norm() for a in @values)

  distance: (b) ->
    @.sub(b).norm()

  sum: ->
    @fold(0, f = (a, b) -> a + b)

  multsum: ->
    @fold(1, (a, b) -> a * b)

  add: (b) ->
    if b.dim == @dim
      new Vector(an + bn for [an, bn] in zip(@values, b.values))

  sub: (b) ->
    @add(b.negative())

  multiply: (b) ->
    if b.dim?
      if b.dim == @dim
        new Vector(an * bn for [an, bn] in zip(@values, b.values))

  entrywise_inverse: ->
    if @values.indexOf(0) == -1
      new Vector(1 / a for a in @values)

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
    if(( @.norm() * b.norm()) != 0)
      Math.acos((@.dot b ) / ( @.norm() * b.norm()))

  #projection of a onto b
  projection: (b) ->
    c = (@.dot b) / (b.dot b)
    new Vector(c * bn for bn in b.values)

  off: (b) ->
    new Vector(a - p for [a, p] in zip(@values, @projection(b).values))

  cross: (b) ->
    if b.dim?
      if @dim == 3 and b.dim == 3
        new Matrix([
          [ 0, -@z, @y]
          [@z, 0, -@x]
          [-@y, @x, 0]
        ]).multiply(b)

  negative: ->
    @scale(-1)

  scale: (c) ->
    new Vector(@for_each((x) -> c * x))

  addEach: (c) ->
    new Vector(@for_each((x) -> x + c))

root = exports ? this
root.Vector = Vector





