class Vector extends ListLike
  constructor: (@values) ->
    @dim = @values.length

  toString: ->
    "Vector"+super

  x: -> @values[0]
  y: -> @values[1]
  z: -> @values[2]
  t: -> @values[3]
  part: (i) -> @values[i]

  norm: -> Math.sqrt(@.dot @)

  normalize: ->
    new Vector(a / @norm() for a in @values)

  distance: (b) ->
    @.sub(b).length()

  sum: ->
    @fold(0, f = (a, b) -> a + b)

  multsum: ->
    @fold(0, (a, b) -> a * b )

  add: (b) ->
    if b.dim == @dim
      new Vector(an + bn for [an, bn] in zip(@values, b.values))

  neg: ->
    new Vector(-a for a in @values)

  sub: (b) ->
    @add(b.neg())

  multiply: (b) ->
    if b.dim?
      if b.dim == @dim
        new Vector(an * bn for [an, bn] in zip(@values, b.values))

  inverse: ->
    if !@values.contains(0)
      new Vector(1 / a for a in @values)

  divide: (b) ->
    @multiply(b.inverse())

  dot: (b) ->
    @multiply(b).sum()

  rotate: (theta, p) ->
    if(@dim == 2)

      cosTheta = Math.cos(theta)
      sinTheta = Math.sin(theta)

      new Vector([
        p.x + @.x * cosTheta - p.x * cosTheta - @.y * sinTheta + p.y * sinTheta
        p.y + @.y * cosTheta - p.y * cosTheta + @.x * sinTheta - p.x * sinTheta
      ])

  rotateDeg: (degress, p) ->
    rad = degrees / 180 * Math.PI
    rotate(rad, p)

  # cos theta = a.b / (len of a * len ofv)
  vectorAngle: (b) ->
    if(( @.norm() * v.norm()) != 0)
      Math.acos((@.dot b ) / ( @.norm() * v.norm()))

  vectorAngleDeg: (b) ->
    vectorAngle(b) / Math.PI * 180

  #projection of a onto b
  projection: (b) ->
    c = (@.dot b) / (b.dot b)
    new Vector(c * bn for bn in b.values)

  off: (b) ->
    new Vector(a - p for [a, p] in zip(@values, @projection(b).values))

  cross: (b) ->
    @

  scale: (c) ->
    @for_each((x) -> c*x)

  addEach: (c) ->
    @for_each((x) -> x+c)

#alternate syntax
class VectorMath
  add: (a, b) ->
    a.add(b)

  sub: (a, b) ->
    a.sub(b)

  multiply: (a, b) ->
    a.multiply(b)

  divide: (a, b) ->
    a.divide(b)

  dot: (a, b) ->
    a.dot(b)

  projection: (a, b) ->
    a.projection(b)

  cross: (a, b) ->
    a.cross(b)



testm = new Matrix([
  ["a","b"]
  ["c","d"]
])

test2 = new Matrix([
  [1,2]
  [3,4]
])

test3 = new Matrix([
  [1,0]
  [0,1]
])

vec1 = new Vector([0,0])
vec2 = new Vector([1,0])
vec3 = new Vector([0,1])
vec4 = new Vector([1,1])

console.log("MATRIX")

console.log(test2.multiply(vec1).toString())
console.log(test2.multiply(vec2).toString())
console.log(test2.multiply(vec3).toString())
console.log(test2.multiply(vec4).toString())

console.log(test2.scale(5))
console.log(test2.add(test3))










