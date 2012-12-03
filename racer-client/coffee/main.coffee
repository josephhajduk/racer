class RACER
  constructor: ->
    console.log "Starting RACER"

    @director = new CAAT.Director()
    @director.initialize 336, 240, document.getElementById('main')
    @director.setClear false

    @control = new Control({},true)

    @control.action_start = (state)->
      #console.log "START:"+state

    new CAAT.ImagePreloader().loadImages racer_resources_json, (counter, images)=>
      if counter == images.length
        @director.setImagesCache(images)

        @opening_scene = new scene_opening(@director)

        CAAT.loop(60)
      else
        #adjust css loading screen
        console.log "LOADING #{counter}/#{images.length}"

racer = new RACER()
