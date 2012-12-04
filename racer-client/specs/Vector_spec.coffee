{Vector} = require '../build/js/app.js'

describe "Vector", ->

  it "can be used to add two simple 2d vectors", ->
    v1 = new Vector([0,1])
    v2 = new Vector([1,0])
    result = v1.add v2
    expect(result.x()).toEqual 1
    expect(result.y()).toEqual 1

  it "can be used to add two large vectors", ->
    v1 = new Vector([0..100])
    v2 = new Vector([0..100])
    result = v1.add v2

    expect(result.dim).toEqual 101
    expect(result.part(n)).toEqual((n)*2) for n in [0..100]