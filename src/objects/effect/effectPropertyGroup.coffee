# --------------------------------------------------------------------------------
# class Hyle.EffectPropertyGroup
# --------------------------------------------------------------------------------
class Hyle.EffectPropertyGroup extends Hyle.PropertyGroup

# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: (@data) ->

# ----------------------------------------
# applyTo
# ----------------------------------------
  applyTo: (object) ->
    super object


# ----------------------------------------
# adapt
# ----------------------------------------
  adapt: () ->
    for propertyName, propertyValue of @data
      property = new Hyle.PropertyInstance propertyName, propertyValue
      property.adapt
        scope: "layer.effects"
      delete @data[propertyName];
      log "#{property.getPropertyName()} = #{property.getPropertyValue()}" if propertyName is "blending mode"
      @data[property.getPropertyName().toTitleCase()] = property.getPropertyValue()
    @
