describe "Matrix", ->
  m1 = new Matrix([
    [1, 1, 1]
    [0, 0, 0]
    [0, 0, 1]
  ])

  m1_t = new Matrix([
    [1, 0, 0]
    [1, 0, 0]
    [1, 0, 1]
  ])

  m2 = new Matrix([
    [1, 2, 1]
    [9, 5, 5]
    [8, 0, 1]
  ])

  describe "should provide accesor methods, which", ->
    it "can be used to print a matrix as a string", ->
      expect(m2.toString()).toEqual "Matrix [\n  [1,2,1]\n  [9,5,5]\n  [8,0,1]\n]"

    it "includes a method element, that can be used to access a single value", ->
      expect(m2.element(0, 0)).toEqual 1
      expect(m2.element(0, 1)).toEqual 2
      expect(m2.element(0, 2)).toEqual 1
      expect(m2.element(1, 0)).toEqual 9
      expect(m2.element(1, 1)).toEqual 5
      expect(m2.element(1, 2)).toEqual 5
      expect(m2.element(2, 0)).toEqual 8
      expect(m2.element(2, 1)).toEqual 0
      expect(m2.element(2, 2)).toEqual 1

    it "includes a method part, that can be used to access a single value", ->
      expect(m2.part(0)).toEqual 1
      expect(m2.part(1)).toEqual 2
      expect(m2.part(2)).toEqual 1
      expect(m2.part(3)).toEqual 9
      expect(m2.part(4)).toEqual 5
      expect(m2.part(5)).toEqual 5
      expect(m2.part(6)).toEqual 8
      expect(m2.part(7)).toEqual 0
      expect(m2.part(8)).toEqual 1

    it "includes a length method which will return the number of elements in the matrix", ->
      expect(m2.length()).toEqual 9

    it "includes a method to return a list of vectors representing the rows", ->
      result = m2.row_vectors()
      for i in [0...3]
        for j in [0...3]
          expect(result[i].part(j)).toEqual m2.element(i, j)

    it "includes a method to return a list of vectors representing the columns", ->
      result = m2.column_vectors()
      for i in [0...3]
        for j in [0...3]
          expect(result[i].part(j)).toEqual m2.element(j, i)


  describe "should provide static methods, including", ->
    it "a function for generating the identity matrix", ->
      result = Matrix.identity(5)
      for i in [0...5]
        for j in [0...5]
          if i == j
            expect(result.element(i, j)).toEqual 1
          else
            expect(result.element(i, j)).toEqual 0

  describe "should provide common unary transformations of the current matrix, including", ->
    it "the transpose", ->
      result = m1.transpose()
      for i in [0...3]
        for j in [0...3]
          expect(result.element(i, j)).toEqual m1_t.element(i, j)

    it "the diagonal", ->
      result = m2.diagonal()
      expect(result.x).toEqual 1
      expect(result.y).toEqual 5
      expect(result.z).toEqual 1

  describe "should provide common calculations on the matrix, including", ->
    it "the trace", ->
      expect(m1.trace()).toEqual 2
      expect(m2.trace()).toEqual 7

  describe "should provide basic matrix operations, which", ->
    it "should allow for multiplying the matrix by a scalar", ->
      result = m2.scale(5.2)
      for i in [0...3]
        for j in [0...3]
          expect(result.element(i, j)).toEqual m2.element(i, j) * 5.2

    it "should allow for adding one matrix to another", ->
      result = m2.add m1
      for i in [0...3]
        for j in [0...3]
          expect(result.element(i, j)).toEqual m2.element(i, j) + m1.element(i, j)

    it "should allow for augmenting a matrix with another", ->
      result = m1.augment m2
      for i in [0...3]
        for j in [0...3]
          expect(result.element(i, j)).toEqual m1.element(i, j)
        for j in [3...6]
          expect(result.element(i, j)).toEqual m2.element(i, j - 3)

    it "should allow for matrix matrix multiplication", ->
      result = m1.multiply m2
      expect(result.element(0, 0)).toEqual 18
      expect(result.element(0, 1)).toEqual 7
      expect(result.element(0, 2)).toEqual 7
      expect(result.element(1, 0)).toEqual 0
      expect(result.element(1, 1)).toEqual 0
      expect(result.element(1, 2)).toEqual 0
      expect(result.element(2, 0)).toEqual 8
      expect(result.element(2, 1)).toEqual 0
      expect(result.element(2, 2)).toEqual 1

    it "should allow for matrix vector multiplication", ->
      v1 = new Vector([1, 2, 3])
      result = m1.multiply v1
      expect(result.x).toEqual 6
      expect(result.y).toEqual 0
      expect(result.z).toEqual 3