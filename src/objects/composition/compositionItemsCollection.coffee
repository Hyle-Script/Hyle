# --------------------------------------------------------------------------------
# class Hyle.CompositionItemsCollection
# --------------------------------------------------------------------------------
class Hyle.CompositionItemsCollection extends Hyle.Collection


# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: () ->
    @compositions = []


# ----------------------------------------
# add
# ----------------------------------------
  add: (composition) ->
    composition.item._id or= composition.item.name
    @compositions[composition.item._id] = composition

# ----------------------------------------
# find
# ----------------------------------------
  find: (key) ->
    return @compositions[key]
