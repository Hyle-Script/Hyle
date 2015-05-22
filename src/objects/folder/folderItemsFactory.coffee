# --------------------------------------------------------------------------------
# class Hyle.FolderItemsFactory
# --------------------------------------------------------------------------------
class Hyle.FolderItemsFactory extends Hyle.Factory

# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: (foldersData) ->
    @folders             = []
    @foldersData         = foldersData
    @folderItemsCollection = hyle.parser.folderItemsCollection


    @nestingLevel        = 0
    @lastStoredFolder    = null
    @currentParentFolder = app.project.rootFolder
    @parentFoldersArray  = []

    @createFolders()
    return @folders


# ----------------------------------------
# createFolders
# ----------------------------------------
  createFolders: () ->
    for folderData in @foldersData

      if typeof folderData is "string" then folderData = {name: folderData}

      if folderData.name.match /^(\| )/gi

        matches = folderData.name.match /(\| )/gi

        if matches.length > @nestingLevel then @incrementNesting matches
        else if matches.length < @nestingLevel then @decrementNesting matches

        folderData.name = folderData.name.replace /^\| +/gi, ""

      else

        folderData.parentFolder ?= folderData.folder || folderData["parent folder"] || null

        if folderData.parentFolder
          @currentParentFolder = @folderItemsCollection.find(folderData.parentFolder).item
        else
          folderData.parentFolder = @currentParentFolder = app.project.rootFolder
        @nestingLevel          = 0
      @lastStoredFolder = @createFolder folderData, @currentParentFolder


# ----------------------------------------
# createFolder
# ----------------------------------------
  createFolder: (data, parent) ->
    folder = new Hyle.FolderItemInstance data
    folder.store()
    folder.setParentFolder parent
    @folderItemsCollection.add folder
    folder.item


# ----------------------------------------
# incrementNesting
# ----------------------------------------
  incrementNesting: (matches) ->
    @nestingLevel++
    @currentParentFolder = @lastStoredFolder
    @parentFoldersArray.push @lastStoredFolder


# ----------------------------------------
# decrementNesting
# ----------------------------------------
  decrementNesting: (matches) ->
    difference           = @nestingLevel - matches.length
    @nestingLevel        = @nestingLevel - difference
    @parentFoldersArray.pop() for i in [1..difference]
    @currentParentFolder = @parentFoldersArray[@parentFoldersArray.length - 1]
