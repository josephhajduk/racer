describe "Vector", ->
  v1 = new Vector([0..100])
  v2 = new Vector([0..5])
  v3 = new Vector([1..4])
  v4 = new Vector([42..31])
  v5 = new Vector([23..123])
  v6 = new Vector([57..212])
  v7 = new Vector([0, 1])
  v8 = new Vector([1, 0])
  v9 = new Vector([0..100])
  v10 = new Vector([0..100])
  v11 = new Vector([5..10])
  v12 = new Vector([1, 2, 3])
  v13 = new Vector([4, 5, 6])

  precision = 0.00001

  describe "should provide some convinent static constants, such as", ->
    it "the unitX method which returns the unit vector in the x direction", ->
      expect(Vector.unitX().x).toEqual 1
      expect(Vector.unitX().y).toEqual 0

    it "the unitY method which returns the unit vector in the y direction", ->
      expect(Vector.unitY().x).toEqual 0
      expect(Vector.unitY().y).toEqual 1

  describe "should provide accesor methods, which", ->
    it "can be used to print a large vector as a string", ->
      expect(v1.toString()).toMatch /Vector ([0-9|,]*)/i

    it "can be used to print a simple vector as a string", ->
      expect(v2.toString()).toEqual "Vector (0,1,2,3,4,5)"

    it "should provide x,y,z, and t properties to access the 0th,1st,2nd, and 3rd elements, respectively", ->
      expect(v3.x).toEqual 1
      expect(v3.y).toEqual 2
      expect(v3.z).toEqual 3
      expect(v3.t).toEqual 4

    it "should provide a part method to access any element by position", ->
      for i in [0..100]
        expect(v1.part(i)).toEqual i

    it "should provide a dim property which is the dimension of the vector", ->
      expect(v1.dim).toEqual 101

  describe "should provide entrywise math functions, which", ->
    it "should provide a negative method which will return a new negative vector", ->
      nv1 = v4.negative()
      for i in [0...v4.dim]
        expect(v4.part(i)).toEqual -1 * nv1.part(i)

    it "should provide a scale method which will multiply every entry by a scalar and return a new vector", ->
      s1 = v5.scale(23)
      for i in [0...v5.dim]
        expect(s1.part(i)).toEqual 23 * v5.part(i)

    it "should provide a addEach method which will add a value to each entry and return a new vector", ->
      a1 = v6.addEach(2)
      for i in [0...v6.dim]
        expect(a1.part(i)).toEqual v6.part(i) + 2

    it "should provide an entrywise_inverse that will comput 1/x for each entry", ->
      i3 = v3.entrywise_inverse()
      for i in [0...v3.dim]
        expect(i3.part(i)).toEqual (1 / v3.part(i))

  describe "should provide basic vector math functions, which", ->
    it "can be used to normalize the vector", ->
      result = v12.normalize()
      expect(result.x).toBeCloseTo 0.267261, precision
      expect(result.y).toBeCloseTo 0.534522, precision
      expect(result.z).toBeCloseTo 0.801784, precision

    it "can be used to add two simple 2d vectors", ->
      result = v7.add v8
      expect(result.x).toEqual 1
      expect(result.y).toEqual 1

    it "can be used to add two large vectors", ->
      result = v9.add v10
      expect(result.dim).toEqual 101
      expect(result.part(n)).toEqual((n) * 2) for n in [0..100]

    it "can be used to subtract two simple 2d vectors", ->
      result = v7.sub v8
      expect(result.x).toEqual -1
      expect(result.y).toEqual 1

    it "should provide a dot method that will compute the dot product with another vector", ->
      result = v11.dot v2
      expect(result).toEqual 130

    it "should provide a method to compute the cross product of two 3d vectors", ->
      result = v12.cross v13
      expect(result.x).toEqual -3
      expect(result.y).toEqual 6
      expect(result.z).toEqual -3

    it "should provide a method to compute the projection of this vector onto another", ->
      result = v12.projection v13
      expect(result.x).toBeCloseTo 1.66234, precision
      expect(result.y).toBeCloseTo 2.07792, precision
      expect(result.z).toBeCloseTo 2.49351, precision

    it "should provide a method to compute the perpendicular vector to the projection of this vector onto another", ->
      result = v12.off v13
      expect(result.x).toBeCloseTo -0.662338, precision
      expect(result.y).toBeCloseTo -0.0779221, precision
      expect(result.z).toBeCloseTo 0.506494, precision

  describe "should provide functions to compute properties of the vector, which", ->
    it "should include the ability to compute the angle between this vector and another", ->
      result = v12.vectorAngle v13
      expect(result - 0.225726).toBeLessThan precision

    it "should include the ability to compute the sum of the vector's components", ->
      result = v3.sum()
      expect(result).toEqual 1 + 2 + 3 + 4

    it "should include the ability to compute the multiplicative sum of the vector's components", ->
      result = v3.multsum()
      expect(result).toEqual 1 * 2 * 3 * 4

    it "should include a method to calculate the distance between this vector and another", ->
      result = v12.distance v13
      expect(result).toBeCloseTo 5.19615, precision

    it "should include a method to calculate the norm of this vector", ->
      result = v12.norm()
      expect(result).toBeCloseTo 3.74166, precision

  describe "should provide functions for linear transformations on this vector, which", ->
    it "should include a rotation method that will rotate a 2d vector", ->
      result = v7.rotate(Math.PI / 5)
      expect(result.x).toBeCloseTo -0.587785, precision
      expect(result.y).toBeCloseTo 0.809017, precision

    it "should include a rotation method that will rotate a 3d vector", ->
      result = v13.rotate(Math.PI / 5, Math.PI / 4, Math.PI / 3)
      expect(result.x).toBeCloseTo 2.59499, precision
      expect(result.y).toBeCloseTo 1.36283, precision
      expect(result.z).toBeCloseTo 8.27096, precision

    it "it should include a general function to apply any transformation", ->
      transformation = new Matrix([
        [1, 0, 1]
        [0, 1, 0]
        [0, 0, 1]
      ])
      result = v13.apply_transformation(transformation)
      expect(result.x).toBeCloseTo 10, precision
      expect(result.y).toBeCloseTo 5, precision
      expect(result.z).toBeCloseTo 6, precision

