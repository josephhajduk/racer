class RotationMatrix2D
  @def: (t) -> [
    [Math.cos(t), -Math.sin(t)]
    [Math.sin(t),  Math.cos(t)]
  ]

  @by: (theta) ->
    new Matrix(@def(theta))

class RotationMatrix3D
  @defX: (t) -> [
    [1,0,0]
    [0,Math.cos(t),-Math.sin(t)]
    [0,Math.sin(t),Math.cos(t)]
  ]

  @defY: (t) -> [
    [Math.cos(t),0,Math.sin(t)]
    [0,1,0]
    [-Math.sin(t),0,Math.cos(t)]
  ]

  @defZ: (t) -> [
    [Math.cos(t),-Math.sin(t),0]
    [Math.sin(t),Math.cos(t),0]
    [0,0,1]
  ]

  @by: (yaw,pitch,roll) ->
    new Matrix(@defX(yaw)).multiply(new Matrix(@defY(pitch))).multiply(new Matrix(@defZ(roll)))

