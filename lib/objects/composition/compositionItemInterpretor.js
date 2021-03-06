// Generated by CoffeeScript 1.10.0
var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

Hyle.CompositionItemInterpretor = (function(superClass) {
  extend(CompositionItemInterpretor, superClass);

  function CompositionItemInterpretor(composition) {
    this.composition = composition;
    this.ignoredProperties = [];
    this.data = {};
    this.ignoredValues = {
      parentFolder: "Root"
    };
    CompositionItemInterpretor.__super__.constructor.apply(this, arguments);
  }

  CompositionItemInterpretor.prototype.compact = function() {
    this.data = CompositionItemInterpretor.__super__.compact.call(this, this.composition);
    if (this.hasLayers()) {
      this.interpretLayers();
    }
    return this.data;
  };

  CompositionItemInterpretor.prototype.hasLayers = function() {
    if (this.composition.layers.length > 0) {
      return true;
    } else {
      return false;
    }
  };

  CompositionItemInterpretor.prototype.interpretLayers = function() {
    var i, j, layerInterpretor, ref, results;
    this.data.layers = [];
    results = [];
    for (i = j = 1, ref = this.composition.layers.length; 1 <= ref ? j <= ref : j >= ref; i = 1 <= ref ? ++j : --j) {
      layerInterpretor = new Hyle.LayerInterpretor(this.composition.layers[i]);
      results.push(this.data.layers.push(layerInterpretor.compact()));
    }
    return results;
  };

  return CompositionItemInterpretor;

})(Hyle.CompositionItem);
