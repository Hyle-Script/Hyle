# --------------------------------------------------------------------------------
# class Hyle.EffectFactory
# --------------------------------------------------------------------------------
class Hyle.EffectFactory extends Hyle.Factory


# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: (@data, @layer) ->

# ----------------------------------------
# applyToLayer
# ----------------------------------------
  applyToLayer: () ->
    for effectData in @data
      effect = new Hyle.EffectInstance effectData, @layer
