# --------------------------------------------------------------------------------
# class Hyle.FolderItemsCollection
# --------------------------------------------------------------------------------
class Hyle.FolderItemsCollection extends Hyle.Collection


# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: () ->
    @folders = []


# ----------------------------------------
# add
# ----------------------------------------
  add: (folder) ->
    folder.item._id or= folder.item.name
    @folders[folder.item._id] = folder

# ----------------------------------------
# find
# ----------------------------------------
  find: (key) ->
    return @folders[key]
