# --------------------------------------------------------------------------------
# class Hyle.Property
# --------------------------------------------------------------------------------
class Hyle.Property extends Hyle.Object


# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: () ->


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
# setValues
# ----------------------------------------
  setValues: (propertyAlias, propertyValue) ->
    @setPropertyValue propertyAlias, propertyValue.value if propertyValue.value
    @setPropertyExpression propertyAlias, propertyValue.expression if propertyValue.expression
    @setPropertyValueAtTime propertyAlias, propertyValue.keyframes if propertyValue.keyframes
    try @setPropertyValue propertyAlias, propertyValue


# ----------------------------------------
# setPropertyValue
# ----------------------------------------
  setPropertyValue: (propertyAlias, propertyValue) ->
    try propertyAlias.setValue propertyValue


# ----------------------------------------
# setPropertyExpression
# ----------------------------------------
  setPropertyExpression: (propertyAlias, propertyExpression) ->
    propertyAlias.expression = propertyExpression


# ----------------------------------------
# setPropertyValueAtTime
# ----------------------------------------
  setPropertyValueAtTime: (propertyAlias, keyframes) ->
    for keyframe in keyframes
      keyframe.time ?= keyframe[0]
      keyframe.time = @convertToFrameIfNeeded keyframe.time
      keyframe.value ?= keyframe[1]
      propertyAlias.setValueAtTime keyframe.time, keyframe.value
      if keyframe.easing
        if previousKeyframe
          timespan = keyframe.time * 24 - previousKeyframe.time * 24
          keyframe.value = keyframe.value - previousKeyframe.value
        else
          timespan = 0
        @setPropertyValueAtTimeEasing propertyAlias, keyframe.easing, propertyAlias.numKeys, keyframe.value, timespan
      previousKeyframe = keyframe


# ----------------------------------------
# validateInAndNotSameAsDefaults
# ----------------------------------------
  validateInAndNotSameAsDefaults: (defaults, key) ->
    if defaults.hasOwnProperty @propertyName then if defaults[@propertyName] isnt @propertyValue then true else false


# ----------------------------------------
# setPropertyValueAtTimeEasing
# ----------------------------------------
  setPropertyValueAtTimeEasing: (propertyAlias, easingType, keyframeId, keyframeValue, timespan) ->
    if keyframeValue instanceof Array
      easing = null
      easeIn = []
      easeOut = []
      for propertyValue in keyframeValue
        easing = @getEasingValue easingType, propertyValue, timespan
        easeIn.push easing.easeIn
        easeOut.push easing.easeOut

      # Weird fix... 3 values asked in arrays don't know why
      if easeIn.length < 3
        easeIn.push easing.easeIn
        easeOut.push easing.easeOut

    else
      easing = @getEasingValue easingType, keyframeValue, timespan
      easeIn = [easing.easeIn]
      easeOut = [easing.easeOut]

    @setTemporalEaseAtKey propertyAlias, keyframeId, easeIn, easeOut


# ----------------------------------------
# setTemporalEaseAtKey
# ----------------------------------------
  setTemporalEaseAtKey: (propertyAlias, keyframeId, easeIn, easeOut) =>
    propertyAlias.setTemporalEaseAtKey(keyframeId, easeIn, easeOut);


# ----------------------------------------
# getEasingValue
# ----------------------------------------
  getEasingValue: (easingType, keyframeValue, timespan) =>
    switch easingType
      when "easy ease", "easy"
        easeIn  = new KeyframeEase 0, 33.3
        easeOut = new KeyframeEase 0, 33.3

      when "ease in", "in"
        easeIn = new KeyframeEase 0, 33.3
        easeOut  = new KeyframeEase keyframeValue * timespan / app.project.activeItem.frameRate, 33.3

      when "ease out", "out"
        easeIn  = new KeyframeEase keyframeValue * timespan / app.project.activeItem.frameRate, 33.3
        easeOut = new KeyframeEase 0, 33.3

    easings =
      easeIn  : easeIn
      easeOut : easeOut

    return easings


# ----------------------------------------
# evalIfDirective
# ----------------------------------------
  evalIfDirective: (propertyValue) =>
    if typeof propertyValue is "string"
      propertyValue = propertyValue.replace /(?:%%)(.+?)(?:%%)/g, (match, p1) ->
        return eval(p1)
    return propertyValue


# ----------------------------------------
# convertToFrameIfNeeded
# ----------------------------------------
  convertToFrameIfNeeded: (propertyValue) ->
    if typeof propertyValue is "string"
      if propertyValue.match(/\w+$/)[0] in ["f", "frame", "frames"]
        if app.project.activeItem
          framerate = app.project.activeItem.frameRate
        else
          framerate = 24
        r = parseInt(propertyValue.replace(/\w+[.!?]?$/, '')) / framerate
    else
      r = propertyValue
    return r


# ----------------------------------------
# getPropertyNameTranslations
# ----------------------------------------
  getPropertyNameTranslations: (opts, dict) ->
    # o: original, t: translations
    translations =
      "global": [
        { o: "_id",                   t: ["id"] },
        { o: "pixelAspect",           t: ["pixel aspect"] },
        { o: "parentFolder",          t: ["folder", "parent folder"] },
        { o: "valueAtTime",           t: ["keyframes"] },
        { o: "frameRate",             t: ["frame rate"] },
      ]

      "layer": [
        { o: "sourceText",            t: ["text"] },
        { o: "blendingMode",          t: ["blending mode"] }
        { o: "motionBlur",            t: ["motion blur"] }
        { o: "trackMatteType",        t: ["track matte"] }
        { o: "parent",                t: ["parent layer"] }
        { o: "parentComp",            t: ["comp", "composition", "parent composition"] }
        { o: "guideLayer",            t: ["guide layer", "guide"] }
        { o: "adjustmentLayer",       t: ["adjustment layer", "adjustment"] }
        { o: "startTime",             t: ["start time"] }
        { o: "inPoint",               t: ["in point"] }
        { o: "outPoint",              t: ["out point"] }
        { o: "frameRate",             t: ["frame rate"] }
        { o: "fillColor",             t: ["fill color"] }
        { o: "threeDLayer",           t: ["3d", "3D"] }
        { o: "zRotation",             t: ["z rotation", "rotation z"] }
        { o: "enabled",               t: ["visible"] }
        { o: "timeRemapping",         t: ["time remapping"] }

      # Camera
        { o: "focusDistance",         t: ["focus distance"] }
        { o: "Point of Interest",     t: ["point of interest"] }
        { o: "depthOfField",          t: ["depth of field"] }
        { o: "blurLevel",             t: ["blur level"] }
        { o: "irisShape",             t: ["iris shape"] }
        { o: "irisRotation",          t: ["iris rotation"] }
        { o: "irisAspectRatio",       t: ["iris aspect ratio"] }
        { o: "irisDiffractionFringe", t: ["iris diffraction fringe"]}
        { o: "highlightGain",         t: ["highlight gain"] }
        { o: "highlightThreshold",    t: ["highlight threshold"] }
        { o: "highlightSaturation",   t: ["highlight saturation"] }

      # Light
        { o: "coneAngle",             t: ["cone angle"] }
        { o: "coneFeather",           t: ["cone feather"] }
        { o: "falloffDistance",       t: ["falloff distance"] }
        { o: "castsShadows",          t: ["casts shadows"] }
        { o: "shadowDarkness",        t: ["shadow darkness"] }
        { o: "shadowDiffusion",       t: ["shadow diffusion"] }

        { o: "anchorPoint",           t: ["anchor point"] }

      # Text
        { o: "fontSize",              t: ["font size"] }
        { o: "fillColor",             t: ["fill color", "font color"] }
        { o: "strokeColor",           t: ["stroke color"] }
        { o: "strokeWidth",           t: ["stroke width"] }
        { o: "strokeOverFill",        t: ["stroke over fill"] }
        { o: "applyStroke",           t: ["apply stroke"] }
        { o: "applyFill",             t: ["apply fill"] }
      ]

      "layer.light.options": [
        {o: "lightType",                t: ["type"]}
      ]

      "layer.mask": [
        {o: "mask path",                t: ["path"]}
        {o: "maskFeather",              t: ["feather"]}
        {o: "maskOpacity",              t: ["opacity"]}
        {o: "maskExpansion",            t: ["expansion"]}
        {o: "maskMode",                 t: ["mode"]}
      ]

      "layer.effects": [
        {o: "blending mode",            t: ["blending mode"]}
      ]

    scope             = opts.scope || "global"
    translationsArray = translations[scope] || []
    translationsArray = translationsArray.concat translations["global"] if opts.scope

    return toDict translationsArray, dict


