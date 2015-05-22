# --------------------------------------------------------------------------------
# class Hyle.LightLayerInstance
# --------------------------------------------------------------------------------
class Hyle.LightLayerInstance extends Hyle.LayerInstance

# ----------------------------------------
# contructor
# ----------------------------------------
  constructor: (data) ->
    super

    @setDefaults
      name: "Light"
      centerPoint: [0, 0]

    @initiate data
    @

# ----------------------------------------
# render
# ----------------------------------------
  render: () ->
    super @data.AVCompItemTarget.layers.addLight @data.name, @data.centerPoint
