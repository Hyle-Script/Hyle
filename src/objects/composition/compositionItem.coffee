# --------------------------------------------------------------------------------
# class Hyle.CompositionItem
# --------------------------------------------------------------------------------
class Hyle.CompositionItem extends Hyle.Item

# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: (data) ->
    super

    @setDefaults
      label       : 15
      width       : 1920
      height      : 1080
      pixelAspect : 1
      duration    : 10
      framerate   : 24
      color       : [0, 0, 0]

    @initiate data

    @
