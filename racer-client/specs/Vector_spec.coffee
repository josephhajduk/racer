describe "Vector", ->
  v1 = new Vector([0..100])
  v2 = new Vector([0..5])
  v3 = new Vector([1..4])
  v4 = new Vector([42..31])
  v5 = new Vector([23..123])
  v6 = new Vector([57..212])
  v7 = new Vector([0,1])
  v8 = new Vector([1,0])
  v9 = new Vector([0..100])
  v10 = new Vector([0..100])
  v11 = new Vector([5..10])

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
        expect(s1.part(i)).toEqual 23*v5.part(i)

    it "should provide a addEach method which will add a value to each entry and return a new vector",->
      a1 = v6.addEach(2)
      for i in [0...v6.dim]
        expect(a1.part(i)).toEqual v6.part(i) + 2

    it "should provide an entrywise_inverse that will comput 1/x for each entry", ->
      i3 = v3.entrywise_inverse()
      for i in [0...v3.dim]
        expect(i3.part(i)).toEqual (1 / v3.part(i))


  it "can be used to add two simple 2d vectors", ->
    result = v7.add v8
    expect(result.x).toEqual 1
    expect(result.y).toEqual 1

  it "can be used to add two large vectors", ->
    result = v9.add v10
    expect(result.dim).toEqual 101
    expect(result.part(n)).toEqual((n)*2) for n in [0..100]

  it "can be used to subtract two simple 2d vectors", ->
    result = v7.sub v8
    expect(result.x).toEqual -1
    expect(result.y).toEqual 1

  it "should provide a dot method that will compute the dot product with another vector", ->
    result = v11.dot v2
    expect(result).toEqual 130

