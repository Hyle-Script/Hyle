# --------------------------------------------------------------------------------
# class Hyle.SolidLayerInstance
# --------------------------------------------------------------------------------
class Hyle.SolidLayerInstance extends Hyle.LayerInstance

# ----------------------------------------
# contructor
# ----------------------------------------
  constructor: (data) ->
    super

    @setDefaults
      name        : "Solid Layer"
      pixelAspect : 1
      color       : [0, 0, 0]
      width       : 1920
      height      : 1080

    @initiate data
    @


# ----------------------------------------
# initiate
# ----------------------------------------
  initiate: (data) ->
    super data


# ----------------------------------------
# render
# ----------------------------------------
  render: () ->
    super @data.AVCompItemTarget.layers.addSolid @data.color, @data.name, @data.width, @data.height, @data.pixelAspect, @data.duration

