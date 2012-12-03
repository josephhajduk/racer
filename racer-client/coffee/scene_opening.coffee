class scene_opening
  constructor: (@director) ->
    @scene = @director.createScene()

    @bg = new CAAT.ActorContainer()
    @bg.setBounds 0, 0, @director.width, @director.height
    @bg.setFillStyle '#0E0'

    @scene.addChild(@bg);

    below = new CAAT.SpriteImage()
    below.initialize(@director.getImage('map_thecity_below'),1,1)

    above = new CAAT.SpriteImage()
    above.initialize(@director.getImage('map_thecity_above'),1,1)

    actor_below = new CAAT.Actor()
    actor_below.setBackgroundImage(below.getRef(),true)

    actor_above = new CAAT.Actor()
    actor_above.setBackgroundImage(above.getRef(),true)

    @bg.addChild(actor_below);
    @bg.addChild(actor_above);