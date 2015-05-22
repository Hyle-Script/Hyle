# --------------------------------------------------------------------------------
# class Hyle.FolderItemInstance
# --------------------------------------------------------------------------------
class Hyle.FolderItemInstance extends Hyle.FolderItem


# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: (data) ->
    @ignoredProperties = ["parentFolder"]

    super
    @initiate data


# ----------------------------------------
# store
# ----------------------------------------
  store: () ->
    super app.project.items.addFolder @data.name
