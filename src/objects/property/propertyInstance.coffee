# --------------------------------------------------------------------------------
# class Hyle.PropertyInstance
# --------------------------------------------------------------------------------
class Hyle.PropertyInstance extends Hyle.Property


# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: (@propertyName, @propertyValue) ->
    super
    @


# ----------------------------------------
# hasKeyframes
# ----------------------------------------
  hasKeyframes: () ->
    (@propertyValue.keyframes ? true : false)


# ----------------------------------------
# apply
# ----------------------------------------
  apply: (object, skip = false) ->
    if skip then @setValues object
    if typeof object.property is "function"
      if object.property(@propertyName)
        if typeof object.property(@propertyName).setValue is "function"
          @setValues object
      else
        try object[@propertyName] = @propertyValue
    else
      object[@propertyName] = @propertyValue


    return @


# ----------------------------------------
# setValues
# ----------------------------------------
  setValues: (object) ->
    super object.property(@propertyName), @propertyValue


# ----------------------------------------
# processValue
# ----------------------------------------
  processValue: (propertyValue) ->
    return propertyValue


# ----------------------------------------
# adapt
# ----------------------------------------
  adapt: (opts = {}) ->
    @propertyName        = @adaptPropertyName @propertyName, opts
    @propertyValue       = @adaptPropertyValue @propertyName, @propertyValue, opts
    return @

# ----------------------------------------
# adaptPropertyName
# ----------------------------------------
  adaptPropertyName: (propertyName, opts) ->
    propertyNamesTranslations = @getPropertyNameTranslations opts, "t"
    translatedPropertyName    = propertyNamesTranslations[propertyName]?["o"] || propertyName
    translatedPropertyName    = translatedPropertyName[0] if translatedPropertyName instanceof Array
    return translatedPropertyName


# ----------------------------------------
# adaptPropertyValue
# ----------------------------------------
  adaptPropertyValue: (propertyName, propertyValue, opts) ->
    if propertyValue
      propertyValue = @evalIfDirective propertyValue
      propertyValue = @makeValueReplacements propertyName, propertyValue, opts

    return propertyValue


# ----------------------------------------
# makeValueReplacements
# ----------------------------------------
  makeValueReplacements: (propertyName, propertyValue, opts) ->
    r = propertyValue

    switch propertyName.toLowerCase()

      when "lighttype"
        r = LightType[propertyValue.toString().toUpperCase()]

      when "blendingmode"
        r = BlendingMode[propertyValue.replace(/( )/g, "_").toString().toUpperCase()] if typeof propertyValue is "string"

      when "trackmattetype"
        r = TrackMatteType[propertyValue.replace(/( )/g, "_").toString().toUpperCase()] if typeof propertyValue is "string"

      when "maskmode"
        r = MaskMode[propertyValue.replace(/( )/g, "_").toString().toUpperCase()] if typeof propertyValue is "string"

      when "color", "color 1", "fillcolor", "color 2", "color 3", "color 4", "color 5", "map black to", "map white to", "tint color", "shadows unbalance", "midtones unbalance", "highlights unbalance", "highlights", "brights", "midtones", "darktones", "shadows", "color to change"
          r = esy.color.hexToHsl propertyValue if typeof propertyValue is "string"

      when "inPoint", "outPoint", "duration", "time"
        r = @convertToFrameIfNeeded(propertyValue)


      when "justification"
        switch propertyValue
          when "left", "center", "right"
            r = ParagraphJustification["#{propertyValue.toUpperCase()}_JUSTIFY"]
          when "justifiedLeft", "justifiedCenter", "justifiedRight"
            r = ParagraphJustification["FULL_JUSTIFY_LASTLINE_#{propertyValue.replace('justified', '').toUpperCase()}"]

    switch opts.scope

      when "layer.shape.contents"

        switch propertyName

          when "type"
            switch propertyValue

              when "rectangle"                          then r = "ADBE Vector Shape - Rect"
              when "ellipse", "circle"                  then r = "ADBE Vector Shape - Ellipse"
              when "polystar"                           then r = "ADBE Vector Shape - Star"
              when "fill"                               then r = "ADBE Vector Graphic - Fill"
              when "stroke"                             then r = "ADBE Vector Graphic - Stroke"
              when "gradient fill"                      then r = "ADBE Vector Graphic - G-Fill"
              when "gradient stroke"                    then r = "ADBE Vector Graphic - G-Stroke"
              when "merge paths"                        then r = "ADBE Vector Filter - Merge"
              when "offset paths"                       then r = "ADBE Vector Filter - Offset"
              when "pucker and bloat", "pucker & bloat" then r = "ADBE Vector Filter - PB"
              when "round corners"                      then r = "ADBE Vector Filter - RC"
              when "trim paths"                         then r = "ADBE Vector Filter - Trim"
              when "twist"                              then r = "ADBE Vector Filter - Twist"
              when "wiggle paths"                       then r = "ADBE Vector Filter - Roughen"
              when "wiggle transform"                   then r = "ADBE Vector Filter - Wiggler"
              when "zig zag"                            then r = "ADBE Vector Filter - Zigzag"
              when "repeater"                           then r = "ADBE Vector Filter - Repeater"


    return r
