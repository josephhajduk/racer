
#alternate syntax
class VectorMath
  add: (a,b) ->
    a.add(b)

  sub: (a,b) ->
    a.sub(b)

  multiply: (a,b) ->
    a.multiply(b)

  divide: (a,b) ->
    a.divide(b)

  dot: (a,b) ->
    a.dot(b)

  projection: (a,b) ->
    a.projection(b)

  cross: (a,b) ->
    a.cross(b)

class Vector
  constructor: (@values) ->
    @dim = @values.length

  clone: -> new Vector(@values[..])

  x: -> @values[0]
  y: -> @values[1]
  z: -> @values[2]
  t: -> @values[3]
  part: (i) -> @values[i]

  norm: -> Math.sqrt(@.dot @)

  distance: (b) ->
    diff = @.sub(b)
    Math.sqrt(diff.dot diff)


  sumF2: (f) ->
    result = 0
    for a in @values
      result += f(result,a)
    return result

  sum: ->
    f = (a,b) -> a+b
    @sumF2(f)

  multsum: ->
    f = (a,b) -> a*b
    @sumF2(f)

  normalize: ->
    new Vector(a/@norm() for a in @values)

  add: (b) ->
    if b.dim = @dim
      new Vector(an+bn for [an,bn] in zip(@values,b.value))

  neg: ->
    new Vector(-a for a in @values)

  sub: (b) ->
    @add b.neg()

  multiply: (b) ->
    if b.dim = @dim
      new Vector(an*bn for [an,bn] in zip(@values,b.value))

  inverse: ->
    if !@values.contains(0)
      new Vector(1/a for a in @values)
    #todo: exception

  divide: (b) ->
    @multiply b.inverse()

  dot: (b) ->
    @multiply(b).sum()

  do: (f) ->
    f(a) for a in @valuess

  rotate: (theta, p) ->
    #assert that dim = 2
    if(@dim = 2)

      cosTheta = Math.cos(theta)
      sinTheta = Math.sin(theta)

      new Vector([
        p.x + @.x * cosTheta - p.x * cosTheta - @.y * sinTheta + p.y * sinTheta
        p.y + @.y * cosTheta - p.y * cosTheta + @.x * sinTheta - p.x * sinTheta
      ])

  rotateDeg: (degress, p) ->
    rad = degrees/180*Math.PI
    rotate(rad,p)

  # cos theta = a.b / (len of a * len ofv)
  VectorAngle: (b) ->
    #todo: verify that length != 0 for both Vectors
    Math.acos( (@.dot b ) / ( @.norm() * v.norm()))

  #projection of a onto b
  projection: (b) ->
    c = (@.dot b) / (b.dot b)

    console.log("Projection:" + c)

    new Vector( c*bn for bn in b.value)

  off: (b) ->
    new Vector( a - p for [a,p] in zip(@values,@projection(b).value))

  cross: (b) ->
    @clone()

  scale: (c) ->
    new Vector( c*a for a in @values)

  polynomial: ->
    (x) -> sum(x^n * @values[n] for n in range(@dim))



v1 = new Vector([0,1])
v2 = new Vector([1,3])
v3 = new Vector([3,2])

proj = v2.projection v1
offof = v2.off v1
console.log(proj)
console.log(offof)
console.log(v3.cross(v2))










