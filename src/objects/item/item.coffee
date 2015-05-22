# --------------------------------------------------------------------------------
# class Hyle.Item
# --------------------------------------------------------------------------------
class Hyle.Item extends Hyle.Object


# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: () ->

    @defaults = {}
    @data     = {}
    @item     = {}

    @setDefaults
      name            : null
      parentFolder    : null
      folder          : null
      comment         : ""
      selected        : false

# ----------------------------------------
# initiate
# ----------------------------------------
  initiate: (data) ->
    @data = @extend data, @defaults


# ----------------------------------------
# setDefaults
# ----------------------------------------
  setDefaults: (defaults) ->
    for key of defaults then @defaults[key] = defaults[key]


# ----------------------------------------
# store
# ----------------------------------------
  store: (item) ->
    @item = item
    @data = @adaptObject @data
    @apply @item, @data


# ----------------------------------------
# setParentFolder
# ----------------------------------------
  setParentFolder: (parentFolder) ->
    @item.parentFolder = parentFolder
