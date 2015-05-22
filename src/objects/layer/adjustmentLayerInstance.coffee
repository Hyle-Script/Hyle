# --------------------------------------------------------------------------------
# class Hyle.AdjustmentLayerInstance
# --------------------------------------------------------------------------------
class Hyle.AdjustmentLayerInstance extends Hyle.SolidLayerInstance

# ----------------------------------------
# contructor
# ----------------------------------------
  constructor: (data) ->
    super

    @setDefaults
      name: "Adjustment Layer"
      adjustmentLayer : true

    @initiate data
    @
