# --------------------------------------------------------------------------------
# class Hyle.Effect
# --------------------------------------------------------------------------------
class Hyle.EffectInstance extends Hyle.Effect


# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: (@data, @layer) ->
    @effect = {}
    @render()


# ----------------------------------------
# render
# ----------------------------------------
  render: () ->
    try
      @effect = @layer.Effects.addProperty @data.type.capitalize()
    catch e
      alert "Hyle is unable find effect named \"#{@data.type.capitalize()}\""

    @effect.name = @data.name if @data.name
    @setEffectProperties()


# ----------------------------------------
# setEffectProperties
# ----------------------------------------
  setEffectProperties: () ->
    propertyGroup = new Hyle.EffectPropertyGroup @data.properties
    propertyGroup.adapt().applyTo @effect
