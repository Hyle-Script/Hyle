# --------------------------------------------------------------------------------
# class Hyle.ShapeLayerInstance
# --------------------------------------------------------------------------------
class Hyle.ShapeLayerInstance extends Hyle.LayerInstance

# ----------------------------------------
# contructor
# ----------------------------------------
  constructor: (data) ->
    data.contents ?= {}
    super

    @setDefaults
      name: "Shape Layer"

    @initiate data
    @

# ----------------------------------------
# render
# ----------------------------------------
  render: () ->
    super @data.AVCompItemTarget.layers.addShape()
    @setShapesProperties @data.contents


# ----------------------------------------
# setShapesTransformProperties
# ----------------------------------------
  setShapesTransformProperties: () ->
      @apply @layer[""], @data.transform, true


# ----------------------------------------
# setShapesProperties
# ----------------------------------------
  setShapesProperties: (contents, vectorGroup = null) ->
    for data in contents
      switch data.type
        when "group"
          vectorGroup = @createShapeGroup data
          @setTransform vectorGroup, data.transform if data.transform
          @setShapesProperties data.contents, vectorGroup
        else
          data.type = new Hyle.PropertyInstance("type", data.type).adapt({scope: "layer.shape.contents"}).getPropertyValue()
          vectorGroup = vectorGroup ?= @layer
          shape       = vectorGroup.property("Contents").addProperty data.type
          @setTransform shape, data.transform if data.transform
          @apply shape, data, true
      vectorGroup = null


# ----------------------------------------
# createShapeGroup
# ----------------------------------------
  createShapeGroup: (groupData) ->
    vectorGroup = @layer.property("Contents").addProperty "ADBE Vector Group"
    vectorGroup.name = groupData.name if groupData?.name
    return vectorGroup
