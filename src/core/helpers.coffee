# --------------------------------------------------------------------------------
# Helpers
# --------------------------------------------------------------------------------


# ----------------------------------------
# isObjectEmpty
# ----------------------------------------
isObjectEmpty = (obj) ->
  r = false
  if obj
    if obj.length > 0
      r = true
  # return false if obj.length? and obj.length > 0

  # for key of obj
  #   return false if Object.prototype.hasOwnProperty.call(obj,key)

  return r


# ----------------------------------------
# isObjectAndNotArray
# ----------------------------------------
isObjectAndNotArray = (obj) ->
  typeof obj is "object" and not (obj instanceof Array)


# ----------------------------------------
# isFoundIn
# ----------------------------------------
isFoundIn = (term, array) -> array.indexOf(term) isnt -1

# ExtendedArray::toDict = (key) ->
toDict = (array, key) ->
  dict = {}
  i = 0
  while i < array.length
    obj = array[i]
    if obj[key] != null
      dict[obj[key]] = obj
    i++
  return dict


# ----------------------------------------
# logError
# ----------------------------------------
logError = (error) ->
  esy.file.create "/#{$.appData}/Hyle/errors.txt",
    """
    #{Date()}
    #{error.toString()}
    """
  , false

# ----------------------------------------
# String::capitalize
# ----------------------------------------
String::capitalize = ->
  @replace /(?:^|\s)\S/g, (a) ->
    a.toUpperCase()


# ----------------------------------------
# String::toTitleCase
# ----------------------------------------
String::toTitleCase = ->
  i = undefined
  str = undefined
  lowers = undefined
  uppers = undefined
  str = @replace(/([^\W_]+[^\s-]*) */g, (txt) ->
    txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()
  )

  # Certain minor words should be left lowercase unless
  # they are the first or last words in the string
  lowers = ["A", "An", "The", "And", "But", "Or", "For", "Nor", "As", "At", "By", "For", "From", "In", "Into", "Near", "Of", "On", "Onto", "To", "With"]
  i = 0
  while i < lowers.length
    str = str.replace(new RegExp("\\s" + lowers[i] + "\\s", "g"), (txt) ->
      txt.toLowerCase()
    )
    i++

  # Certain words such as initialisms or acronyms should be left uppercase
  uppers = ["Id", "Tv"]
  i = 0
  while i < uppers.length
    str = str.replace(new RegExp("\\b" + uppers[i] + "\\b", "g"), uppers[i].toUpperCase())
    i++
  str


# ----------------------------------------
# invert
# ----------------------------------------
#
# Inverts an objects keys and value
# {a: b} -> {b: a}
#
# ----------------------------------------
invert = (obj) ->
  new_obj = {}
  for prop of obj
    if obj.hasOwnProperty(prop)
      new_obj[obj[prop]] = prop
  new_obj


# ----------------------------------------
# clone
# ----------------------------------------
#
# Creates a deep copy of given object
#
# ----------------------------------------
clone = (obj) ->
  r = obj
  if typeof (obj) is "object"
    temp = {}
    for key of obj
      temp[key] = obj[key]
  r = temp
  r


# ----------------------------------------
# dotAccess
# ----------------------------------------
dotAccess = (obj, str) ->
  str = str.split('.')
  i = 0
  while i < str.length
    try obj = obj[str[i]]
    i++
  obj
