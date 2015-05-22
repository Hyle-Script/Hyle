# --------------------------------------------------------------------------------
# class Hyle.Object
# --------------------------------------------------------------------------------
class Hyle.Object


# ----------------------------------------
# extend
# ----------------------------------------
  extend: (sourceObject, defaultObject, adapt = false) ->
    for propertyName, propertyValue of defaultObject
      propertyValue = sourceObject[propertyName] if sourceObject[propertyName]
      property      = new Hyle.PropertyInstance propertyName, propertyValue
      property      = property.adapt()

      if not sourceObject[property.getPropertyName()]
        sourceObject[property.getPropertyName()] = property.getPropertyValue()

    return sourceObject

# ----------------------------------------
# apply
# ----------------------------------------
  apply: (object, data, adapt = false) ->
    for propertyName, propertyValue of data
      if propertyName not in @ignoredProperties
        property = new Hyle.PropertyInstance propertyName, propertyValue
        property.adapt() if adapt
        try property.apply object

    return object


# ----------------------------------------
# adaptObject
# ----------------------------------------
  adaptObject: (objectData, opts = {}) ->
    for propertyName, propertyValue of objectData
      property = new Hyle.PropertyInstance propertyName, propertyValue
      property = property.adapt opts
      delete objectData[propertyName];
      objectData[property.getPropertyName()] = property.getPropertyValue()

    return objectData

# ----------------------------------------
# buffer
# ----------------------------------------
  buffer: (target, propertyName) ->
    bufferCounter = 0
    r = () ->
      if target[propertyName]
        return true
      else
        if bufferCounter < 10
          bufferCounter++
          $.sleep 100
          r()
        else
          return false
    r()


# ----------------------------------------
# compact
# ----------------------------------------
#
# Very gross, should clean this up...
#
# ----------------------------------------
  compact: (object, opts = {}) ->
    data = {}
    if @validateNotIgnoredItem object
      for key of object
        try value = object[key]
        try
          if value and typeof object[key] isnt "function"
            if key not in @ignoredProperties
              propertyInterpretor = new Hyle.PropertyInterpretor key, value
              if propertyInterpretor.validateNotInIgnoredValues @ignoredValues
                if opts.bypassDefaults is true or propertyInterpretor.validateInAndNotSameAsDefaults(@defaults)
                  propertyInterpretor.adapt()
                  data[propertyInterpretor.getPropertyName()] = propertyInterpretor.getStringifiedPropertyValue()
        catch e
          logError e
      data
    else
      false

# ----------------------------------------
# validateNotIgnoredItem
# ----------------------------------------
  validateNotIgnoredItem: (object) ->
    r = true
    if @ignoredItems
      for key of @ignoredItems
        r = false if object[key] is @ignoredItems[key]
    r


