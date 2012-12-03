class Matrix extends Countable
  constructor: (@values) ->
    @dim_n = values.length
    @dim_m = values[0].length

  length: -> @dim_n*@dim_m

  part: (i) ->
    row = Math.floor(i / dim_m);
    col = i % dim_m
    @values[row][col]

  row_vectors: () ->
    new Vector(row) for row in @values

  column_vectors: () ->
    new Vector(row) for row in @transpose().values

  entry_wise: (f) ->
    new Matrix(
      f(@values[j][i]) for i in range(@dim_m) for j in range(@dim_n)
    )

  entry_wise_binary: (b,f) ->
    if b.dim_m? and b.dim_n?
      if b.dim_m == @dim_m and b.dim_n == @dim_n
        new Matrix(
          f(@values[j][i],b.values[j][i]) for i in range(@dim_m) for j in range(@dim_n)
        )

  scale: (c) ->
    @entry_wise((x)-> c*x)

  add: (b) ->
    @entry_wise_binary(b, (x,y)->x+y )

  multiply: (b) ->
    if b.dim?
      if b.dim == @dim_m
        console.log(b)
        console.log(b.multiply(row).toString()) for row in @row_vectors()
        new Vector(
            b.dot(row) for row in @row_vectors()
          )
    else if b.dim_m?
      if @dim_n == b.dim_m
        new Matrix(
          @multiply(col).values for col in b.column_vectors()
        ).transpose()

  transpose: ->
    new Matrix(@values[j][i] for j in range(@dim_n) for i in range(@dim_m))
