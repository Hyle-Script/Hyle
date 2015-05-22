# --------------------------------------------------------------------------------
# class Hyle.Collection
# --------------------------------------------------------------------------------
class Hyle.Collection


# ----------------------------------------
# getAVItem
# ----------------------------------------
  getAVItem: (nameOrId) ->
    switch typeof nameOrId
      when "string"
        r = @getAVItemByName nameOrId
      when "number"
        r = @getAVItemById nameOrId
    return r


# ----------------------------------------
# add
# ----------------------------------------
  add: (object) ->


# ----------------------------------------
# find
# ----------------------------------------
  find: (key) ->


# ----------------------------------------
# getAVItemByName
# ----------------------------------------
  getAVItemByName: (name) ->
    for i in [1..app.project.numItems]
      if app.project.item(i).name is name
        return app.project.item(i)


# ----------------------------------------
# getAVItemById
# ----------------------------------------
  getAVItemById: (_id) ->
    return @cache.content[_id]?.AVItem


# ----------------------------------------
# getFromCache
# ----------------------------------------
  getFromCache: (_id) ->
    return @cache.content[_id]
