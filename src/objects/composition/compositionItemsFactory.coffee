# --------------------------------------------------------------------------------
# class Hyle.CompositionItemsFactory
# --------------------------------------------------------------------------------
class Hyle.CompositionItemsFactory extends Hyle.Factory

# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: (compositionsData) ->
    @composition

    @compositionItemsCollection = hyle.parser.compositionItemsCollection
    @folderItemsCollection      = hyle.parser.folderItemsCollection
    @createCompositions compositionsData


# ----------------------------------------
# createCompositions
# ----------------------------------------
  createCompositions: (compositionsData) ->
    for compositionData in compositionsData
      @composition = new Hyle.CompositionItemInstance compositionData
      @composition.store()
      @setParentComposition compositionData.composition if compositionData.composition
      @setParentFolder compositionData.folder if compositionData.folder
      @fetchComposition compositionData.fetch if compositionData.fetch
      @createLayers compositionData.layers if compositionData.layers

      @compositionItemsCollection.add @composition


# ----------------------------------------
# setParentComposition
# ----------------------------------------
  setParentComposition: (compositionPointer) ->
    parentComposition = @compositionItemsCollection.find(compositionPointer).item
    @composition.setParentComposition parentComposition


# ----------------------------------------
# fetchComposition
# ----------------------------------------
  fetchComposition: (compositionPointer) ->
    fetchedComposition = @compositionItemsCollection.find(compositionPointer).item
    @composition.item.layers.add fetchedComposition

# ----------------------------------------
# setParentFolder
# ----------------------------------------
  setParentFolder: (folderPointer) ->
    parentFolder = @folderItemsCollection.find(folderPointer).item
    @composition.setParentFolder parentFolder


# ----------------------------------------
# createLayers
# ----------------------------------------
  createLayers: (layersData) ->
    layersFactory = new Hyle.LayersFactory layersData, @composition
