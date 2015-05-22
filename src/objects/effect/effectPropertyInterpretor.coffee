# --------------------------------------------------------------------------------
# class Hyle.EffectInterpretor
# --------------------------------------------------------------------------------
class Hyle.EffectPropertyInterpretor extends Hyle.EffectProperty


# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: (@effectProperty) ->
    @ignoredProperties = [
      "active",
      "canSetExpression",
      "canVaryOverTime",
      "enabled",
      "expressionEnabled",
      "hasMax",
      "hasMin",
      "isTimeVarying",
      "isSpatial",
      "isModified"
      "matchName",
      "maxValue",
      "minValue",
      "numProperties",
      "numKeys",
      "parentProperty",
      "propertyDepth",
      "propertyIndex",
      "propertyType",
      "propertyValueType",
      "selectedKeys",
      "unitsText"
    ]

    @ignoredItems =
      matchName: "ADBE Effect Built In Params"

    @data = {}

    super


# ----------------------------------------
# compact
# ----------------------------------------
  compact: () ->
    if @effectProperty.isModified
      @data = super @effectProperty, {bypassDefaults: true}
    else
      false
