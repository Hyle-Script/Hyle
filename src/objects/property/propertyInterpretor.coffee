# --------------------------------------------------------------------------------
# class Hyle.PropertyInterpretor
# --------------------------------------------------------------------------------
class Hyle.PropertyInterpretor extends Hyle.Property


# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: (@propertyName, propertyValue) ->

    if isObjectAndNotArray propertyValue then propertyValue = propertyValue.name ? propertyValue.id

    @propertyValue = propertyValue
    super
    @


# ----------------------------------------
# getPropertyName
# ----------------------------------------
  getPropertyName: () ->
    @propertyName


# ----------------------------------------
# getPropertyValue
# ----------------------------------------
  getPropertyValue: () ->
    @propertyValue


# ----------------------------------------
# getStringifiedPropertyValue
# ----------------------------------------
  getStringifiedPropertyValue: () ->
    response = @propertyValue
    if @propertyValue instanceof FolderItem or @propertyValue instanceof CompItem or @propertyValue instanceof FootageItem or @propertyValue instanceof Layer
      response = @propertyValue.name
    response


# ----------------------------------------
# isInIgnoredValues
# ----------------------------------------
  validateNotInIgnoredValues: (ignoredValues) ->
    if ignoredValues?[@propertyName] isnt @propertyValue then true else false


# ----------------------------------------
# adapt
# ----------------------------------------
  adapt: (opts = {}) ->
    @propertyName  = @adaptPropertyName @propertyName, opts
    @propertyValue = @adaptPropertyValue @propertyName, @propertyValue, opts
    return @


# ----------------------------------------
# adaptPropertyName
# ----------------------------------------
  adaptPropertyName: (propertyName, opts) ->
    propertyNamesTranslations = @getPropertyNameTranslations opts, "o"
    translatedPropertyName    = propertyNamesTranslations[propertyName]?["t"] || propertyName
    translatedPropertyName    = translatedPropertyName[0] if translatedPropertyName instanceof Array
    return translatedPropertyName


# ----------------------------------------
# adaptPropertyValue
# ----------------------------------------
  adaptPropertyValue: (propertyName, propertyValue, opts) ->
    if propertyValue
      propertyValue = @evalIfDirective propertyValue
      propertyValue = @makeValueReplacements propertyName, propertyValue

    return propertyValue


# ----------------------------------------
# makeValueReplacements
# ----------------------------------------
  makeValueReplacements: (propertyName, propertyValue, opts) ->
    r = propertyValue
    switch propertyName.toLowerCase()
      when "color", "color 1", "fillcolor", "color 2", "color 3", "color 4", "color 5", "map black to", "map white to", "tint color", "shadows unbalance", "midtones unbalance", "highlights unbalance", "highlights", "brights", "midtones", "darktones", "shadows", "color to change"
          r = esy.color.rgbToHex propertyValue

      when "outpoint", "inpoint", "duration"
        r = Math.round(propertyValue * 10) / 10

    r
