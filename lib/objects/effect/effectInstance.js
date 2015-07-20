// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Hyle.EffectInstance = (function(_super) {
  __extends(EffectInstance, _super);

  function EffectInstance(data, layer) {
    this.data = data;
    this.layer = layer;
    this.effect = {};
    this.render();
  }

  EffectInstance.prototype.render = function() {
    var e;
    try {
      this.effect = this.layer.Effects.addProperty(this.data.type.capitalize());
    } catch (_error) {
      e = _error;
      alert("Hyle is unable find effect named \"" + (this.data.type.capitalize()) + "\"");
    }
    if (this.data.name) {
      this.effect.name = this.data.name;
    }
    return this.setEffectProperties();
  };

  EffectInstance.prototype.setEffectProperties = function() {
    var propertyGroup;
    propertyGroup = new Hyle.EffectPropertyGroup(this.data.properties);
    return propertyGroup.adapt().applyTo(this.effect);
  };

  return EffectInstance;

})(Hyle.Effect);