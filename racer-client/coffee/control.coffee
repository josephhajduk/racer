class Control

  constructor: (setSettings={},@debug=false) ->
    #default handlers

    @defaultSettings =
      steer_deadzone: 0.1
      throttle_deadzone: 0.1
      breaks_deadzone: 0.1
      button_threshold: 0.5
      kb_map:
        38: "throttle"
        40: "breaks"
        37: "steer_left"
        39: "steer_right"
        65: "start"
        83: "button1"
        68: "button2"
        70: "button3"
        71: "button4"
      gamepad: 0
      gamepad_map:
        start:
          kind:"button"
          id:0
        button1:
          kind:"button"
          id:1
        button2:
          kind:"button"
          id:2
        button3:
          kind:"button"
          id:3
        button4:
          kind:"button"
          id:4
        steer:
          kind:"axis"
          id:2
        throttle: #throttle ignores values < 0
          kind:"axis"
          invert:true
          id:1
        breaks: #break ignores values < 0
          kind:"axis"
          invert:false
          id:1

    @action_start = (state) =>
      if @debug and state
        console.log("action:start->#{state}")

    @action_button1 = (state) =>
      if @debug and state
        console.log("action:button1->#{state}")

    @action_button2 = (state) =>
      if @debug and state
        console.log("action:button2->#{state}")

    @action_button3 = (state) =>
      if @debug and state
        console.log("action:button3->#{state}")

    @action_button4 = (state) =>
      if @debug and state
        console.log("action:button4->#{state}")

    @action_steer_left = (amount) =>
      if @debug
        console.log("action:steer->#{-amount}")

    @action_steer_right = (amount) =>
      if @debug
        console.log("action:steer->#{amount}")

    @action_steer = (amount) =>
      if @debug 
        console.log("action:steer->#{amount}")

    @action_throttle = (amount) =>
      if @debug 
        console.log("action:throttle->#{amount}")

    @action_breaks = (amount) =>
      if @debug 
        console.log("action:breaks->#{amount}")

    @settings = []

    for key,attr of @defaultSettings
      @settings[key] = attr

    for key,attr of setSettings
      @settings[key] = attr

    if gamepadSupport.init()
      requestAnimFrame => @poll_gamepad()

    CAAT.registerKeyListener @handle_keydown

  handle_keydown: (key_event)=>
    for key,action of @settings.kb_map
      if key_event.keyCode.toString() == key
        func = @["action_#{action}"]
        if key_event.action == "up"
          func(0)
        if key_event.action == "down"
          func(1)

    #console.log key_event

  poll_gamepad: ->
    gamepad = gamepadSupport?.gamepads[@settings.gamepad];
    if gamepad?
      for action, mapping of @settings.gamepad_map
        func = @["action_#{action}"]
        if mapping.kind == "button"
          func(gamepad.buttons[mapping.id] > @settings.button_threshold)
        else if mapping.kind = "axis"
          value = gamepad.axes[mapping.id]

          if Math.abs(value) > @settings["#{action}_deadzone"]
            if mapping.invert
              value = -value
            func(value)

    requestAnimFrame => @poll_gamepad()

  doConfigureScene: (director) ->
    #we need to "pause" this director
    #then pop up a nice UI for configuring controls



