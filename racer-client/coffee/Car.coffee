###
Copyright (C) 2013 Solidys Ltd.  All rights reserved.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
###

class Car
  constructor: (director)->
    # @car_image should be a CAAT.SpriteImage that contains all the sprites used for the car
    @car_image = new CAAT.SpriteImage()
      .initialize director.getImage("car_"+color), 1, 20

    @angle_index = [5,6,7,8,9,0,11,12,13,14,15,16,17,18,19,1,10,2,3,4]

    @actor = new CAAT.Actor()
      .setBackgroundImage(this.car_image.getRef(),true)
      .centerAt(0,0)

    @velocity = new Vector([0,0])
    @position = new Vector([0,0])

    @throttle = 0
    @break_pedal = 0
    @steering = 0

    pointCar(@steeringVector())

  #sets the position of the car
  setPosition: (pos)->
    @actor.centerAt pos.x + @actor.width/2, pos.y + @actor.height/2

  # returns a vector corresponding to the direction of the front wheels based on the steering parameter
  steeringVector: ->
    Vector.unitX.rotate(@steering)

  # pointCar adjusts the sprite of the car actor so that it appears to be pointing in the direction of the supplied
  # directionVector.  @angle_index is to allow for improperly ordered sprite sheets
  pointCar: (directionVector) ->
    twopi = Math.PI*2
    pie_size = twopi/@angle_index.length
    angle = Vector.unitX.vectorAngle directionVector
    index = Math.floor ((((angle+pie_size/2)%twopi)+twopi)%twopi)/pie_size
    @actor.setSpriteImage(@angle_index[index])