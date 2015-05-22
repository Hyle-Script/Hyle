class Hyle.Api
  parse: (data) ->
    hyle.parse data
    @

  parseFile: (file) ->
    hyle.parse esy.file.read file
    @

  compose: () ->
    hyle.composer.compose()

  execute: (fn) ->
    fn()
    @

  then: (fn) ->
    @execute fn
    @
