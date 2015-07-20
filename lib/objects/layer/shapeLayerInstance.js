// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Hyle.ShapeLayerInstance = (function(_super) {
  __extends(ShapeLayerInstance, _super);

  function ShapeLayerInstance(data) {
    if (data.contents == null) {
      data.contents = {};
    }
    ShapeLayerInstance.__super__.constructor.apply(this, arguments);
    this.setDefaults({
      name: "Shape Layer"
    });
    this.initiate(data);
    this;
  }

  ShapeLayerInstance.prototype.render = function() {
    ShapeLayerInstance.__super__.render.call(this, this.data.AVCompItemTarget.layers.addShape());
    return this.setShapesProperties(this.data.contents);
  };

  ShapeLayerInstance.prototype.setShapesTransformProperties = function() {
    return this.apply(this.layer[""], this.data.transform, true);
  };

  ShapeLayerInstance.prototype.setShapesProperties = function(contents, vectorGroup) {
    var data, shape, _i, _len, _results;
    if (vectorGroup == null) {
      vectorGroup = null;
    }
    _results = [];
    for (_i = 0, _len = contents.length; _i < _len; _i++) {
      data = contents[_i];
      switch (data.type) {
        case "group":
          vectorGroup = this.createShapeGroup(data);
          if (data.transform) {
            this.setTransform(vectorGroup, data.transform);
          }
          this.setShapesProperties(data.contents, vectorGroup);
          break;
        default:
          data.type = new Hyle.PropertyInstance("type", data.type).adapt({
            scope: "layer.shape.contents"
          }).getPropertyValue();
          vectorGroup = vectorGroup != null ? vectorGroup : vectorGroup = this.layer;
          shape = vectorGroup.property("Contents").addProperty(data.type);
          if (data.transform) {
            this.setTransform(shape, data.transform);
          }
          this.apply(shape, data, true);
      }
      _results.push(vectorGroup = null);
    }
    return _results;
  };

  ShapeLayerInstance.prototype.createShapeGroup = function(groupData) {
    var vectorGroup;
    vectorGroup = this.layer.property("Contents").addProperty("ADBE Vector Group");
    if (groupData != null ? groupData.name : void 0) {
      vectorGroup.name = groupData.name;
    }
    return vectorGroup;
  };

  return ShapeLayerInstance;

})(Hyle.LayerInstance);