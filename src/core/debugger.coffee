# --------------------------------------------------------------------------------
# class Hyle.debugger
# --------------------------------------------------------------------------------
class Hyle.Debugger

  initialize: () ->
    if hyle.debug
      # @testParser()
      # @testComposer()
      # @testTemp()

      @testComposer()
      # @testCompositions()
      # @testLayers()
      # @testTexts()
      # @testShapes()
      # @testEffects()
      # @testKeyframes()
      # @testMasks()

  testParser: () ->
    @testFolders()
    @testCompositions()
    @testLayers()
    @testShapes()
    @testTexts()
    @testMasks()
    @testEffects()
    @testKeyframes()

  testComposer: () ->
    esy.file.create "~/Dropbox/_Personnal/code/scripts/hyle/data/hyle-compose.hyle", hyle.api.compose()

  testFolders: () ->
    hyle.api.parseFile "~/Dropbox/_Personnal/code/scripts/hyle/data/folders.hyle"

  testCompositions: () ->
    hyle.api.parseFile "~/Dropbox/_Personnal/code/scripts/hyle/data/compositions.hyle"

  testLayers: () ->
    hyle.api.parseFile "~/Dropbox/_Personnal/code/scripts/hyle/data/layers.hyle"

  testShapes: () ->
    hyle.api.parseFile "~/Dropbox/_Personnal/code/scripts/hyle/data/shapeLayers.hyle"

  testTexts: () ->
    hyle.api.parseFile "~/Dropbox/_Personnal/code/scripts/hyle/data/textLayers.hyle"

  testMasks: () ->
    hyle.api.parseFile "~/Dropbox/_Personnal/code/scripts/hyle/data/masks.hyle"

  testEffects: () ->
    hyle.api.parseFile "~/Dropbox/_Personnal/code/scripts/hyle/data/effects.hyle"

  testKeyframes: () ->
    hyle.api.parseFile "~/Dropbox/_Personnal/code/scripts/hyle/data/keyframes.hyle"

  testTemp: () ->
    hyle.api.parseFile "~/Dropbox/_Personnal/code/scripts/hyle/data/temp.hyle"
