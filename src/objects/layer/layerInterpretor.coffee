# --------------------------------------------------------------------------------
# class Hyle.LayerInterpretor
# --------------------------------------------------------------------------------
class Hyle.LayerInterpretor extends Hyle.Layer


# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: (@layer) ->
    @ignoredProperties = ["nullLayer", "adjustmentLayer"]
    super


# ----------------------------------------
# compact
# ----------------------------------------
  compact: () ->
    @data = super @layer

    @interpretLayerType()

    @interpretLayerEffects() if @hasEffects()

    @data


# ----------------------------------------
# interpretLayerType
# ----------------------------------------
  interpretLayerType: () ->
    type = ""
    if @layer.adjustmentLayer
      type = "adjustment"
    else if @layer instanceof CameraLayer
      type = "camera"
    else if @layer instanceof LightLayer
      type = "light"
    else if @layer instanceof ShapeLayer
      type = "shape"
    else if @layer instanceof TextLayer
      type = "text"
    else if @layer.nullLayer
      type = "null"
    else if @layer.source
      if @layer.source.frameDuration < 1
        type = "file"
      else
        type = "solid"

    @data.type = type


# ----------------------------------------
# hasEffects
# ----------------------------------------
  hasEffects: () ->
    r = false
    if @layer.Effects then if @layer.Effects.numProperties > 0
      r = true
    r


# ----------------------------------------
# interpretLayerEffects
# ----------------------------------------
  interpretLayerEffects: () ->
    @data.effects = []
    for i in [1..@layer.Effects.numProperties]
      effectInterpretor = new Hyle.EffectInterpretor @layer.Effects.property i
      @data.effects.push effectInterpretor.compact()
