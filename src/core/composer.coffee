class Hyle.Composer

# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: () ->
    @composedContent =
      folders: []
      compositions: []
      files: []

# ----------------------------------------
# compose
# ----------------------------------------
  compose: () ->
    @listItems app.project.numItems

    composedContent = @stringify @composedContent
    composedContent = @cleanUp composedContent
    return composedContent

# ----------------------------------------
# cleanUp
# ----------------------------------------
  cleanUp: (content) ->
    content = content.replace /\-(\r\n|\n|\r)/gm, "-"     # Remove additionnal linebreaks
    content = content.replace /\- {2,}/gm, "- "           # Remove additionnal space
    content = content.replace /\: \'(.+)'/gm, ": $1"      # Remove single quotes
    return content

# ----------------------------------------
# append
# ----------------------------------------
  append: (category, content) ->
    if not isObjectEmpty content
      @composedContent[category].push content


# ----------------------------------------
# stringify
# ----------------------------------------
  stringify: (composedContent) ->
    content = hyle.yaml.stringify composedContent, 50, 2
    return content


# ----------------------------------------
# listItems
# ----------------------------------------
  listItems: (dataSet) ->
    for i in [1..dataSet]
      @listFolder app.project.item(i)      if app.project.item(i) instanceof FolderItem
      @listComposition app.project.item(i) if app.project.item(i) instanceof CompItem
      @listFile app.project.item(i)        if app.project.item(i) instanceof FootageItem

# ----------------------------------------
# listFolder
# ----------------------------------------
  listFolder: (folderItem) ->
    folderItemInterpretor = new Hyle.FolderItemInterpretor folderItem
    @append "folders", folderItemInterpretor.compact()


# ----------------------------------------
# listComposition
# ----------------------------------------
  listComposition: (compositionItem) ->
    compositionItemInterpretor = new Hyle.CompositionItemInterpretor compositionItem
    @append "compositions", compositionItemInterpretor.compact()


# ----------------------------------------
# listFile
# ----------------------------------------
  listFile: (fileItem) ->
    fileItemInterpretor = new Hyle.FileItemInterpretor fileItem
    @append "files", fileItemInterpretor.compact()



