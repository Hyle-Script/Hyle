# --------------------------------------------------------------------------------
# class Hyle.Mask
# --------------------------------------------------------------------------------
class Hyle.Mask extends Hyle.Object


# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: (data, layer) ->
    mask = @setMask data, layer
    return mask

# ----------------------------------------
# setMask
# ----------------------------------------
  setMask: (maskData, AVLayer) ->
    maskData = @adaptObject maskData,
      scope: "layer.mask"
    mask      = AVLayer.Masks.addProperty "Mask"
    mask.name = maskData.name if mask.name
    for propertyName, propertyValue of maskData
      switch propertyName
        when "mask path"
          myShape        = @setMaskShape propertyValue
          myShape.closed = maskData.closed or= true
          mask.property("ADBE Mask Shape").setValue myShape
        when "maskMode", "inverted", "rotoBezier", "maskMotionBlur", "locked", "color", "maskFeatherFalloff"
          mask[propertyName] = propertyValue
    @apply mask, maskData
      # @setProperty mask.property(propertyName.capitalize()), propertyValue

# ----------------------------------------
# setMaskShape
# ----------------------------------------
  setMaskShape: (maskPathData) ->
    shape         = new Shape()
    verticesArray = []
    if isObjectAndNotArray maskPathData
      verticesArray = @setMaskShapeVertices maskPathData
      tangents      = @setMaskShapeVerticesTangents maskPathData
    else
      verticesArray = maskPathData.path ?= verticesData
      tangents =
        inTangents : maskPathData.inTangents ?= [[0, 0], [0, 0], [0, 0], [0, 0]]
        outTangents : maskPathData.outTangents ?= [[0, 0], [0, 0], [0, 0], [0, 0]]

    shape.vertices    = verticesArray
    shape.inTangents  = tangents.inTangents
    shape.outTangents = tangents.outTangents

    return shape

# ----------------------------------------
# setMaskShapeVertices
# ----------------------------------------
  setMaskShapeVertices: (maskPathData) ->
    verticesArray = []
    x             = maskPathData.position[0]
    y             = maskPathData.position[1]
    width         = maskPathData.width
    height        = maskPathData.height

    if maskPathData.type is "rectangle"
      verticesArray.push [x, y]
      verticesArray.push [x + width, y]
      verticesArray.push [x + width, y + height]
      verticesArray.push [x, y + height]
    if maskPathData.type is "ellipse"
      verticesArray.push [x + width / 2, y]
      verticesArray.push [x + width, y + height / 2]
      verticesArray.push [x + width / 2, y + height]
      verticesArray.push [x, y + height / 2]

    return verticesArray

# ----------------------------------------
# setMaskShapeVerticesTangents
# ----------------------------------------
  setMaskShapeVerticesTangents: (maskPathData) ->
    if maskPathData.type is "ellipse"
      widthTangent  = maskPathData.width * 2 * (Math.sqrt(2)-1) / 3
      heightTangent = maskPathData.height * 2 * (Math.sqrt(2)-1) / 3

      inTangents    = [[-widthTangent, 0], [0, -heightTangent], [widthTangent, 0], [0, heightTangent]]
      outTangents   = [[widthTangent, 0],[0, heightTangent],[-widthTangent, 0],[0, -heightTangent]]

    else outTangents = inTangents  = [[0, 0], [0, 0], [0, 0], [0, 0]]

    tangents      = {inTangents : inTangents, outTangents : outTangents}

    return tangents

