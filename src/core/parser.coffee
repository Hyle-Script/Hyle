# --------------------------------------------------------------------------------
# class Hyle.parser
# --------------------------------------------------------------------------------
class Hyle.Parser

# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: () ->
    @data = null
    @cache =
      content: {}

    @fileItemsCollection        = new Hyle.FileItemsCollection
    @folderItemsCollection      = new Hyle.FolderItemsCollection
    @compositionItemsCollection = new Hyle.CompositionItemsCollection
    @layersCollection           = new Hyle.LayersCollection

    @fileItemsFactory           = new Object
    @folderItemsFactory         = new Object
    @compositionItemsFactory    = new Object
    @layersFactory              = new Object


# ----------------------------------------
# parse
# ----------------------------------------
  parse: (data) ->
    @data = @parseYaml data
    @processData()


# ----------------------------------------
# processData
# ----------------------------------------
  processData: () ->
    @processRootData()
    @finishProcess()

# ----------------------------------------
# processRootData
# ----------------------------------------
  processRootData: () ->
    if @data
      @createFolders @data.folders if @data.folders
      @createFileImports @data.files
      @createCompositions @data.compositions if @data.compositions
      @createLayers @data.layers if @data.layers


# ----------------------------------------
# preParseYaml
# ----------------------------------------
  preParseYaml: (yaml) ->
    yaml = yaml.replace /\t/g,"  "
    yaml = yaml.replace /(color ?(.+)?): ([0-9]{6})/gi, "$1: '$3'"
    yaml = yaml.replace /: ?([0-9\.]+[^0-9\n\r]{2,})/gi, ": '$1'"
    yaml = yaml.replace /\{\{|\}\}/g, "%%"
    yaml = yaml.replace /null/g, "'Null'"
    return yaml


# ----------------------------------------
# parseYaml
# ----------------------------------------
  parseYaml: (yaml) ->
    yaml = @preParseYaml yaml
    yaml = hyle.yaml.parse yaml
    return yaml


# ----------------------------------------
# finishProcess
# ----------------------------------------
  finishProcess: () ->


# ----------------------------------------
# createFileImports
# ----------------------------------------
  createFileImports: (filesData = []) ->
    @fileItemsFactory = new Hyle.FileItemsFactory filesData


# ----------------------------------------
# createFolders
# ----------------------------------------
  createFolders: (foldersData) ->
    @folderItemsFactory = new Hyle.FolderItemsFactory foldersData


# ----------------------------------------
# createCompositions
# ----------------------------------------
  createCompositions: (compositionsData) ->
    @compositionItemsFactory = new Hyle.CompositionItemsFactory compositionsData

# ----------------------------------------
# createLayers
# ----------------------------------------
  createLayers: (layersData) ->
    @layersFactory = new Hyle.LayersFactory layersData

