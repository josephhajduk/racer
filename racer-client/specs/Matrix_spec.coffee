describe "Matrix", ->
  describe "should provide static methods, including", ->
    it "a function for generating the identity matrix", ->
      result = Matrix.identity(5)
      for i in [0...5]
        for j in [0...5]
          if i == j
            expect(result.element(i, j)).toEqual 1
          else
            expect(result.element(i, j)).toEqual 0

  describe "should provide common transformations of the current vector, including", ->
    it "the transpose", ->
      matrix = [
        [1, 1, 1]
        [0, 0, 0]
        [0, 0, 1]
      ]
      matrix_t = [
        [1, 0, 0]
        [1, 0, 0]
        [1, 0, 1]
      ]
      result = new Matrix(matrix).transpose()
      expected_result = new Matrix(matrix_t)

      for i in [0...3]
        for j in [0...3]
          expect(result.element(i, j)).toEqual expected_result.element(i, j)