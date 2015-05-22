# --------------------------------------------------------------------------------
# class Hyle.FileLayerInstance
# --------------------------------------------------------------------------------
class Hyle.FileLayerInstance extends Hyle.LayerInstance

# ----------------------------------------
# contructor
# ----------------------------------------
  constructor: (data) ->
    @file = {}

    super

    @setDefaults
      label: 5


    @initiate data
    @


# ----------------------------------------
# render
# ----------------------------------------
  render: () ->
    @file  = hyle.parser.fileItemsCollection.getFileOrImport @data.file
    super @data.AVCompItemTarget.layers.add @file
