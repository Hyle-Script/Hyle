# --------------------------------------------------------------------------------
# class Hyle.CompositionItemInstance
# --------------------------------------------------------------------------------
class Hyle.CompositionItemInstance extends Hyle.CompositionItem


# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: (data) ->
    @ignoredProperties = ["parentFolder"]

    super
    @initiate data


# ----------------------------------------
# store
# ----------------------------------------
  store: () ->
    super app.project.items.addComp @data.name, @data.width, @data.height, @data.pixelAspect, @data.duration, @data.framerate
    @item.bgColor = new Hyle.PropertyInstance("color", @data.color).adapt().getPropertyValue()
    @item.openInViewer?()


# ----------------------------------------
# setParentComposition
# ----------------------------------------
  setParentComposition: (parentComposition) ->
    parentComposition.layers.add @item

