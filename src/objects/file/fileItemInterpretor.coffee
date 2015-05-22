# --------------------------------------------------------------------------------
# class Hyle.CompositionItemInterpretor
# --------------------------------------------------------------------------------
class Hyle.FileItemInterpretor extends Hyle.FileItem


# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: (@file) ->
    @ignoredProperties = ["items", "numItems", "typeName"]
    super


# ----------------------------------------
# compact
# ----------------------------------------
  compact: () ->
    data = {}
    if @file.parentFolder.name isnt "Solids"
      data      = super @file
      data.path = @file.mainSource.file.toString()

    data
