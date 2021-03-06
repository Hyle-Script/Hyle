// Generated by CoffeeScript 1.10.0
var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

Hyle.LayersCollection = (function(superClass) {
  extend(LayersCollection, superClass);

  function LayersCollection() {
    this.layers = [];
  }

  LayersCollection.prototype.add = function(layer) {
    var base;
    (base = layer.layer)._id || (base._id = layer.layer.name);
    return this.layers[layer.layer._id] = layer;
  };

  LayersCollection.prototype.find = function(key) {
    return this.layers[key];
  };

  return LayersCollection;

})(Object);
