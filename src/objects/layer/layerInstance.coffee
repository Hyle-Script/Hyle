# --------------------------------------------------------------------------------
# class Hyle.LayerInstance
# --------------------------------------------------------------------------------
class Hyle.LayerInstance extends Hyle.Layer


# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: () ->
    @defaults = {}

    @setDefaults
      name            : null
      duration        : 10


# ----------------------------------------
# initiate
# ----------------------------------------
  initiate: (data) ->
    @sourceData       = clone data
    @layersCollection = hyle.parser.layersCollection

    @data             = @extend data, @defaults


# ----------------------------------------
# setDefaults
# ----------------------------------------
  setDefaults: (defaults) ->
    for key of defaults
      @defaults[key] = defaults[key]


# ----------------------------------------
# setPostRenderProperties
# ----------------------------------------
  setPostRenderProperties: () ->
    if @data.transform then @setTransform()
    if @data.effects then @setEffects()
    if @data.styles then @setStyles()
    if @data.masks then @setMasks()
    if @data.options then @setOptions()
    if @data.parent then @setParent()



# ----------------------------------------
# setParent
# ----------------------------------------
  setParent: () ->
    @layer.parent = hyle.parser.layersCollection.find(@data.parent).layer


# ----------------------------------------
# setTransform
# ----------------------------------------
  setTransform: (target = null, data = null) ->
    target = @layer if not target
    data = @data.transform if not data
    @apply target["transform"], data, true


# ----------------------------------------
# setOptions
# ----------------------------------------
  setOptions: (target = null, data = null) ->
    target = @layer if not target
    data = @data.options if not data
    @apply target, data, true


# ----------------------------------------
# setStyles
# ----------------------------------------
  setStyles: () ->
    for styleData in @data.styles
      try
        type = styleData.type.toTitleCase()
        app.executeCommand app.findMenuCommandId type
        layerStyle = @layer.property("Layer Styles").property type
        @setStyleProperties layerStyle, styleData
      catch
        logError "Hyle is unable find layer style named \"#{styleData.type.toTitleCase()}\""


# ----------------------------------------
# setStylesProperties
# ----------------------------------------
  setStyleProperties: (layerStyle, styleData) ->
    @apply layerStyle, styleData, true


# ----------------------------------------
# setEffects
# ----------------------------------------
  setEffects: () ->
    effectPropertiesApplier = new Hyle.EffectFactory @data.effects, @layer
    effectPropertiesApplier.applyToLayer()


# ----------------------------------------
# setMasks
# ----------------------------------------
  setMasks: () ->
    for maskData in @data.masks
      mask = new Hyle.Mask maskData, @layer


# ----------------------------------------
# render
# ----------------------------------------
  render: (layer) ->
    @layer = layer
    @data = @adaptObject @data,
      scope: "layer"
    @apply @layer, @data
    @setPostRenderProperties()
