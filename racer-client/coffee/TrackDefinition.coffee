###
Copyright (C) 2013 Solidys Ltd.  All rights reserved.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
###

class TrackDefinition
  constructor: (director) ->
    @director = director

    @name = "Track Name"
    @description = "Track Description"

    @assets = []
    @features = []

    @background_image = ""
    @foreground_image = ""

    @background_animation_actors = []
    @foreground_animation_actors = []

    @wall_paths = []

    @start_line = new Line(
      new Vector([0,0]),
    new Vector([0,1])
    )

    @check_points = []


  dynamic_paths: (scene_time) ->
    _.flatten([feature.dynamicPaths(t) for feature in @features])

  obstacles: (scene_time, car, checkpoint_progress) ->
    andFunc = (memo, num) -> memo and num
    _.reduce(
      [feature.obstacle(time, car, check_point_progress) for feature in @features],
      andFunc,
      false
    )

  force_field: (time,position) ->
    addFunc = (memo, num) -> memo.add num
    _reduce(
      [feature.force_field(time,position) for feature in @features],
      addFunc
      new Vector([0,0])
    )

  wind: (time,position) ->
    addFunc = (memo, num) -> memo.add num
    _reduce(
      [feature.wind(time,position) for feature in @features],
      addFunc
      new Vector([0,0])
    )
    #todo:  pull wind behind cars
