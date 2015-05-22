# --------------------------------------------------------------------------------
# class Hyle.LayersFactory
# --------------------------------------------------------------------------------
class Hyle.LayersFactory extends Hyle.Factory

# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: (layersData, composition = null) ->
    @layersData       = layersData
    @layersCollection = hyle.parser.layersCollection
    @composition      = composition
    @createLayers()
    @


# ----------------------------------------
# createLayers
# ----------------------------------------
  createLayers: () ->
    for layerData in @layersData
      layerData = @inherit layerData if layerData.inherit
      layerData.AVCompItemTarget  = @getComposition layerData
      layer                       = @createLayer layerData
      @layersCollection.add layer


# ----------------------------------------
# createLayer
# ----------------------------------------
  createLayer: (data) ->
    data.type or= "Solid"
    switch data.type.capitalize()
      when "Solid" then layer      = new Hyle.SolidLayerInstance      data
      when "Adjustment" then layer = new Hyle.AdjustmentLayerInstance data
      when "Null" then layer       = new Hyle.NullLayerInstance       data
      when "Light" then layer      = new Hyle.LightLayerInstance      data
      when "Camera" then layer     = new Hyle.CameraLayerInstance     data
      when "Shape" then layer      = new Hyle.ShapeLayerInstance      data
      when "Text" then layer       = new Hyle.TextLayerInstance       data
      when "File" then layer       = new Hyle.FileLayerInstance       data
      else
        logError "The layer type “#{data.type}” is unknown."
    layer.render()
    return layer




# ----------------------------------------
# inherit
# ----------------------------------------
  inherit: (data) ->
    target = @layersCollection.find data.inherit
    for propertyName, propertyValue of target.sourceData
      if propertyName isnt "id"
        data[propertyName] or= propertyValue
    return data


# ----------------------------------------
# getComposition
# ----------------------------------------
  getComposition: (data) ->
    target = do ->
      if data.composition then data.composition
      else if @composition then @composition
      else
        try
          app.project.activeItem
        catch
          alert "Layer #{@name} does not have a parent composition. Use the “composition” property to define one."
