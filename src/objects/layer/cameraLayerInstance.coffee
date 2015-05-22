# --------------------------------------------------------------------------------
# class Hyle.CameraLayerInstance
# --------------------------------------------------------------------------------
class Hyle.CameraLayerInstance extends Hyle.LayerInstance

# ----------------------------------------
# contructor
# ----------------------------------------
  constructor: (data) ->
    super

    @setDefaults
      name: "Camera"
      centerPoint: [0, 0]

    @initiate data
    @



# ----------------------------------------
# render
# ----------------------------------------
  render: () ->
    super @data.AVCompItemTarget.layers.addCamera @data.name, @data.centerPoint

