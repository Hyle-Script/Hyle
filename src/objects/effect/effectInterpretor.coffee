# --------------------------------------------------------------------------------
# class Hyle.EffectInterpretor
# --------------------------------------------------------------------------------
class Hyle.EffectInterpretor extends Hyle.Effect


# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: (@effect) ->
    @ignoredProperties = [
      "active",
      "canSetEnabled",
      "enabled",
      "isEffect",
      "isModified",
      "matchName",
      "numProperties",
      "parentProperty",
      "propertyDepth",
      "propertyIndex",
      "propertyType"
    ]
    @data              = {}
    super


# ----------------------------------------
# compact
# ----------------------------------------
  compact: () ->
    @data = super @effect, {bypassDefaults: true}
    @interpretEffectProperties() if @hasEffectProperties()
    @data

# ----------------------------------------
# hasEffectProperties
# ----------------------------------------
  hasEffectProperties: () ->
    @effect.numProperties > 0

# ----------------------------------------
# interpretEffectProperties
# ----------------------------------------
  interpretEffectProperties: () ->
    @data.properties = []
    for i in [1..@effect.numProperties]
      effectPropertyInterpretor = new Hyle.EffectPropertyInterpretor @effect.property i
      propertyInterpreted = effectPropertyInterpretor.compact()
      @data.properties.push propertyInterpreted if propertyInterpreted
