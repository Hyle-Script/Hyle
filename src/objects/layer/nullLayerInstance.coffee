# --------------------------------------------------------------------------------
# class Hyle.NullLayerInstance
# --------------------------------------------------------------------------------
class Hyle.NullLayerInstance extends Hyle.LayerInstance

# ----------------------------------------
# contructor
# ----------------------------------------
  constructor: (data) ->
    super

    @setDefaults
      name: "Null"

    @initiate data
    @

# ----------------------------------------
# render
# ----------------------------------------
  render: () ->
    super @data.AVCompItemTarget.layers.addNull @data.duration

