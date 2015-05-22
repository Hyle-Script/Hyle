# --------------------------------------------------------------------------------
# class Hyle.TextDocument
# --------------------------------------------------------------------------------
class Hyle.TextDocument extends Hyle.Property

# ----------------------------------------
# contructor
# ----------------------------------------
  constructor: (@data) ->
    @layer = null
    @setValue()


# ----------------------------------------
# setTextDocument
# ----------------------------------------
  setTextDocument: () ->
    sourceText   = @layer.property "Source Text"
    textDocument = {}

    textDocument = @setTextDocumentProperty sourceText

    @setValues sourceText, textDocument


    ###
    Know bug here: The textDocument doesn't apply when there are keyframes
    The code below should be a good starting point but doesn't work.

    if @data.sourceText.keyframes
      textDocument.keyframes = []
      for keyframe in @data.sourceText.keyframes
        textDocument.keyframes.push
          time: keyframe.time
          value: @setTextDocumentProperty sourceText
    ###


# ----------------------------------------
# setTextDocumentProperty
# ----------------------------------------
  setTextDocumentProperty: (sourceText) ->
    textDocument = sourceText.value
    textDocument.resetCharStyle()

    for propertyName in ["fontSize", "fillColor", "strokeWidth", "font", "strokeOverFill", "applyStroke", "applyFill", "justification", "tracking"]
      textDocument[propertyName] = @data[propertyName]

    return textDocument

# ----------------------------------------
# setValues
# ----------------------------------------
  setValues: (sourceText, textDocument) ->
    super sourceText, textDocument


# ----------------------------------------
# setLayer
# ----------------------------------------
  setLayer: (layer) ->
    @layer = layer


# ----------------------------------------
# getValue
# ----------------------------------------
  getValue: () ->
    @value


# ----------------------------------------
# setValue
# ----------------------------------------
  setValue: () ->
    if typeof @data is "string"
      @value = @data
    else if @data.value
      @value = @data.value
    else
      @value = ""


# ----------------------------------------
# getTextDocumentSourceText
# ----------------------------------------
  getTextDocumentSourceText: () ->
