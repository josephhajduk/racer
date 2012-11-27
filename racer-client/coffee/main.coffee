#load the resource list
console.log "Starting RACER"

director = new CAAT.Director()
director.initialize 336, 240, document.getElementById('main')
director.setClear false

new CAAT.ImagePreloader().loadImages racer_resources_json, (counter, images)->
  if counter == images.length
    director.setImagesCache(images)
    alert "GODJ"
    CAAT.loop(60)
  else
    console.log "LOADING #{counter}/#{images.length}"
