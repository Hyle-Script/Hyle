# --------------------------------------------------------------------------------
# class Hyle.TextLayerInstance
# --------------------------------------------------------------------------------
class Hyle.TextLayerInstance extends Hyle.LayerInstance

# ----------------------------------------
# contructor
# ----------------------------------------
  constructor: (data) ->
    super

    @setDefaults
      name            : "Text Layer"
      text            : ""
      fontSize        : 72
      fillColor       : [1, 1, 1]
      strokeColor     : [0, 0, 0]
      strokeWidth     : 0
      font            : "Helvetica"
      strokeOverFill  : false
      applyStroke     : false
      applyFill       : true
      justification   : "center"
      tracking        : 0

    @initiate data
    @


# ----------------------------------------
# initiate
# ----------------------------------------
  initiate: (data) ->
    @hasName = data.name?

    super data


# ----------------------------------------
# render
# ----------------------------------------
  render: () ->
    textDocument = new Hyle.TextDocument @data
    super @data.AVCompItemTarget.layers.addText textDocument.getValue()
    @layer.name = textDocument.getValue() if not @hasName

    textDocument.setLayer @layer
    textDocument.setTextDocument()
