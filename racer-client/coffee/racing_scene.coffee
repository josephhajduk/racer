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

  dynamic_paths: (scene_time) ->
    [feature.dynamic_path(t) for feature in @features]

  obstacles: (scene_time, car, checkpoint_progress) ->
    [feature.obstacle(time,car,check_point_progress) for feature in @features]
    # TODO: fold right or

