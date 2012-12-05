class Matrix extends Countable
  constructor: (@values) ->
    @dim_m = values.length
    @dim_n = values[0].length

  @identity: (n) ->
    ident = (i, j) ->
      if i == j
        1
      else
        0

    new Matrix(ident(i, j) for i in [0...n] for j in [0...n])

  augment: (b) ->
    if b.dim?
      #vector
      if b.dim == @dim_m
        new Matrix(@values[r].push(b.values[r]) for r in [0...@dim_m])

    if b.dim_m?
      if b.dim_m == @dim_m
        new Matrix(@values[r].concat(b.values[r]) for r in [0...@dim_m])


  diagonal: ->
    new Vector(@values[i][i] for i in [0...Math.min(@dim_m, @dim_n)])

  trace: ->
    @diagonal().sum()

  toString: ->
    "Matrix [\n" + ("  [#{row.join(",")}]" for row in @values).join("\n") + "\n]"

  length: -> @dim_n * @dim_m

  part: (i) ->
    row = Math.floor(i / @dim_m);
    col = i % @dim_m
    @values[row][col]

  element: (row, column) ->
    @values[row][column]

  row_vectors: () ->
    new Vector(row) for row in @values

  column_vectors: () ->
    new Vector(row) for row in @transpose().values

  entry_wise: (f) ->
    new Matrix(
      f(@values[j][i]) for i in [0...@dim_m] for j in [0...@dim_n]
    )

  entry_wise_binary: (b, f) ->
    if b.dim_m? and b.dim_n?
      if b.dim_m == @dim_m and b.dim_n == @dim_n
        new Matrix(
          f(@values[j][i], b.values[j][i]) for i in [0...@dim_m] for j in [0...@dim_n]
        )

  scale: (c) ->
    @entry_wise((x)-> c * x)

  add: (b) ->
    @entry_wise_binary(b, (x, y)->x + y)

  multiply: (b) ->
    if b.dim?
      if b.dim == @dim_m
        new Vector(
          b.dot(row) for row in @row_vectors()
        )
    else if b.dim_m?
      if @dim_n == b.dim_m
        new Matrix(
          @multiply(col).values for col in b.column_vectors()
        ).transpose()

  transpose: ->
    new Matrix(@values[j][i] for j in [0...@dim_n] for i in [0...@dim_m])

root = exports ? this
root.Matrix = Matrix