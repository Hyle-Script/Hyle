# --------------------------------------------------------------------------------
# class Hyle.CompositionItemInterpretor
# --------------------------------------------------------------------------------
class Hyle.CompositionItemInterpretor extends Hyle.CompositionItem


# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: (@composition) ->
    @ignoredProperties = []
    @data              = {}
    @ignoredValues     =
      parentFolder: "Root"

    super


# ----------------------------------------
# compact
# ----------------------------------------
  compact: () ->
    @data = super @composition
    if @hasLayers() then @interpretLayers()
    @data


# ----------------------------------------
# hasLayers
# ----------------------------------------
  hasLayers: () ->
    if @composition.layers.length > 0 then true else false

# ----------------------------------------
# interpretLayers
# ----------------------------------------
  interpretLayers: () ->
    @data.layers = []
    for i in [1..@composition.layers.length]
      layerInterpretor = new Hyle.LayerInterpretor @composition.layers[i]
      @data.layers.push layerInterpretor.compact()
