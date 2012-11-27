console.log "Starting RACER"

director = new CAAT.Director()
director.initialize 336, 240, document.getElementById('main')
director.setClear false

new CAAT.ImagePreloader().loadImages racer_resources_json, (counter, images)->
  if counter == images.length
    director.setImagesCache(images)
    #hide css loading screen

    alert "GODJ"

    CAAT.loop(60)
  else
    #adjust css loading screen
    console.log "LOADING #{counter}/#{images.length}"
