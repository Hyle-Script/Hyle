# --------------------------------------------------------------------------------
# class Hyle.FileItemsCollection
# --------------------------------------------------------------------------------
class Hyle.FileItemsCollection extends Hyle.Collection

# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: () ->
    @files = []

# ----------------------------------------
# getFileObject
# ----------------------------------------
  getFileObject: (id) ->
    @files[id]

# ----------------------------------------
# getFile
# ----------------------------------------
  getFile: (id) ->
    if @getFileObject id
      @getFileObject(id).file
    else
      false


# ----------------------------------------
# getFileOrImport
# ----------------------------------------
  getFileOrImport: (id) ->
    if @getFile id
      @getFile id
    else
      path = id
      fileData =
        path: path
        name: esy.file.fileName path
      file     = hyle.parser.fileItemsFactory.createFile fileData
      file.item


# ----------------------------------------
# add
# ----------------------------------------
  add: (file) ->
    file.item._id or= file.getFileName()
    @files[file.item._id] = file
