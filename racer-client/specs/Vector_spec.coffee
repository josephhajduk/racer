{Vector} = require '../build/js/app.js'

describe "Vector", ->

  it "can be used to print a large vector as a string", ->
    v1 = new Vector([0..100])
    expect(v1.toString()).toMatch /Vector ([0-9|,]*)/i

  it "can be used to print a simple vector as a string", ->
    v1 = new Vector([0..5])
    expect(v1.toString()).toEqual "Vector (0,1,2,3,4,5)"

  it "should provide x,y,z, and t properties to access the 0th,1st,2nd, and 4th elements, respectively", ->
    v1 = new Vector([1..4])
    expect(v1.x).toEqual 1
    expect(v1.y).toEqual 2
    expect(v1.z).toEqual 3
    expect(v1.t).toEqual 4

  it "should provide a part method to access any element by position", ->
    v1 = new Vector([0..100])
    for i in [0..100]
      expect(v1.part(i)).toEqual i

  it "should provide a dim property which is the dimension of the vector", ->
    v1 = new Vector([0..100])
    expect(v1.dim).toEqual 101

  it "should provide a negative method which will return a new negative vector", ->
    v1 = new Vector([42..31])
    nv1 = v1.negative()
    for i in [0...v1.dim]
      expect(v1.part(i)).toEqual -1 * nv1.part(i)

  it "can be used to add two simple 2d vectors", ->
    v1 = new Vector([0,1])
    v2 = new Vector([1,0])
    result = v1.add v2

    expect(result.x).toEqual 1
    expect(result.y).toEqual 1

  it "can be used to add two large vectors", ->
    v1 = new Vector([0..100])
    v2 = new Vector([0..100])
    result = v1.add v2

    expect(result.dim).toEqual 101
    expect(result.part(n)).toEqual((n)*2) for n in [0..100]