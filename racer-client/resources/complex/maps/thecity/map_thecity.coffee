{exec} = require 'child_process'

exports.process = (options)->

  resource_file = "#{__dirname}/map_thecity.psd"
  console.log "Processing: #{resource_file} into: #{options.output}"

  #make sure directory exists
  exec "mkdir -p #{options.output}/resources/maps/thecity/"

  #create above layer from layer 4
  exec "/usr/local/bin/convert #{resource_file}[4] #{options.output}/resources/maps/thecity/above.png"

  #create below layer from layer3 and layer2
  exec "/usr/local/bin/convert -coalesce -gravity center #{resource_file}[2] #{resource_file}[3] -layers flatten #{options.output}/resources/maps/thecity/below.png"

  #add entires to the resource list
  exec "echo \"{id:'map_thecity_above', url:'resources/maps/thecity/above.png'},\" >> #{options.output}/resources/resources.js"
  exec "echo \"{id:'map_thecity_below', url:'resources/maps/thecity/below.png'},\" >> #{options.output}/resources/resources.js"
