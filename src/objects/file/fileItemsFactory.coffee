# --------------------------------------------------------------------------------
# class Hyle.FileItemsFactory
# --------------------------------------------------------------------------------
class Hyle.FileItemsFactory extends Hyle.Factory

# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: (filesData) ->
    @files               = []
    @fileItemsCollection = hyle.parser.fileItemsCollection
    @createFiles filesData
    @

# ----------------------------------------
# createFiles
# ----------------------------------------
  createFiles: (filesData) ->
    for fileData in filesData
      @createFile fileData

# ----------------------------------------
# createFile
# ----------------------------------------
  createFile: (fileData) ->
    file = new Hyle.FileItemInstance fileData
    file.store()
    @fileItemsCollection.add file
