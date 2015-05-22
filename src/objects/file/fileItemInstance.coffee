# --------------------------------------------------------------------------------
# class Hyle.FileItemInstance
# --------------------------------------------------------------------------------
class Hyle.FileItemInstance extends Hyle.FileItem


# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: (data) ->
    if typeof data is "string" then data = {path: data}

    super
    @initiate data

# ----------------------------------------
# store
# ----------------------------------------
  store: () ->
    importOptions          = new ImportOptions(File(@data.path))
    importOptions.sequence = true if @data.sequence
    super app.project.importFile importOptions
    @item.selected          = false if not @data.selected


# ----------------------------------------
# getFileName
# ----------------------------------------
  getFileName: () ->
    return esy.file.fileName @item.path
