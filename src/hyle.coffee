`#include "../lib/core/hyle.js"`

hyle = new Hyle()

# Keep the debug attribute in this file,
# it gets replaced at Sublime ExtendScript compile
$.debug = hyle.debug = true

# Components
`#include "../components/yaml-js/yaml.js"`
`#include "../components/esy/esy.jsx"`


# Core
`#include "../lib/core/parser.js"`
`#include "../lib/core/debugger.js"`
`#include "../lib/core/api.js"`
`#include "../lib/core/composer.js"`
`#include "../lib/core/helpers.js"`


# Objects
`#include "../lib/objects/object/object.js"`


# Factories
`#include "../lib/objects/factory.js"`


# Collections
`#include "../lib/objects/collection.js"`


# Item
`#include "../lib/objects/item/item.js"`


# Property
`#include "../lib/objects/property/property.js"`
`#include "../lib/objects/property/propertyGroup.js"`
`#include "../lib/objects/property/propertyInterpretor.js"`
`#include "../lib/objects/property/propertyInstance.js"`


# Composition
`#include "../lib/objects/composition/compositionItem.js"`
`#include "../lib/objects/composition/compositionItemInterpretor.js"`
`#include "../lib/objects/composition/compositionItemInstance.js"`
`#include "../lib/objects/composition/compositionItemsCollection.js"`
`#include "../lib/objects/composition/compositionItemsFactory.js"`


# File
`#include "../lib/objects/file/fileItem.js"`
`#include "../lib/objects/file/fileItemsFactory.js"`
`#include "../lib/objects/file/fileItemsCollection.js"`
`#include "../lib/objects/file/fileItemInstance.js"`
`#include "../lib/objects/file/fileItemInterpretor.js"`


# Folder
`#include "../lib/objects/folder/folderItem.js"`
`#include "../lib/objects/folder/folderItemsCollection.js"`
`#include "../lib/objects/folder/folderItemInstance.js"`
`#include "../lib/objects/folder/folderItemsFactory.js"`
`#include "../lib/objects/folder/folderItemInterpretor.js"`


# Layer
`#include "../lib/objects/layer/layer.js"`
`#include "../lib/objects/layer/layerInstance.js"`
`#include "../lib/objects/layer/layerInterpretor.js"`
`#include "../lib/objects/layer/layersFactory.js"`
`#include "../lib/objects/layer/layersCollection.js"`
`#include "../lib/objects/layer/solidLayerInstance.js"`
`#include "../lib/objects/layer/adjustmentLayerInstance.js"`
`#include "../lib/objects/layer/nullLayerInstance.js"`
`#include "../lib/objects/layer/lightLayerInstance.js"`
`#include "../lib/objects/layer/cameraLayerInstance.js"`
`#include "../lib/objects/layer/shapeLayerInstance.js"`
`#include "../lib/objects/layer/textLayerInstance.js"`
`#include "../lib/objects/layer/fileLayerInstance.js"`


# Mask
`#include "../lib/objects/mask/mask.js"`


# Effect
`#include "../lib/objects/effect/effectPropertyGroup.js"`
`#include "../lib/objects/effect/effect.js"`
`#include "../lib/objects/effect/effectFactory.js"`
`#include "../lib/objects/effect/effectInstance.js"`
`#include "../lib/objects/effect/effectInterpretor.js"`
`#include "../lib/objects/effect/effectProperty.js"`
`#include "../lib/objects/effect/effectPropertyInterpretor.js"`


# TextDocument
`#include "../lib/objects/textDocument/textDocument.js"`


# Akward way to create palettes
hyle.container = this

hyle.initialize()
