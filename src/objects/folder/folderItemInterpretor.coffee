# --------------------------------------------------------------------------------
# class Hyle.FolderItemInterpretor
# --------------------------------------------------------------------------------
class Hyle.FolderItemInterpretor extends Hyle.FolderItem


# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: (@folder) ->
    @ignoredProperties = []

    @ignoredValues     =
      parentFolder: "Root"

    super

# ----------------------------------------
# compact
# ----------------------------------------
  compact: () ->
    super @folder
