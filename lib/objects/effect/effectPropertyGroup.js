// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Hyle.EffectPropertyGroup = (function(_super) {
  __extends(EffectPropertyGroup, _super);

  function EffectPropertyGroup(data) {
    this.data = data;
  }

  EffectPropertyGroup.prototype.applyTo = function(object) {
    return EffectPropertyGroup.__super__.applyTo.call(this, object);
  };

  EffectPropertyGroup.prototype.adapt = function() {
    var property, propertyName, propertyValue, _ref;
    _ref = this.data;
    for (propertyName in _ref) {
      propertyValue = _ref[propertyName];
      property = new Hyle.PropertyInstance(propertyName, propertyValue);
      property.adapt({
        scope: "layer.effects"
      });
      delete this.data[propertyName];
      if (propertyName === "blending mode") {
        log("" + (property.getPropertyName()) + " = " + (property.getPropertyValue()));
      }
      this.data[property.getPropertyName().toTitleCase()] = property.getPropertyValue();
    }
    return this;
  };

  return EffectPropertyGroup;

})(Hyle.PropertyGroup);