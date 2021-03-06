// Generated by CoffeeScript 1.10.0
var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

Hyle.EffectInterpretor = (function(superClass) {
  extend(EffectInterpretor, superClass);

  function EffectInterpretor(effect) {
    this.effect = effect;
    this.ignoredProperties = ["active", "canSetEnabled", "enabled", "isEffect", "isModified", "matchName", "numProperties", "parentProperty", "propertyDepth", "propertyIndex", "propertyType"];
    this.data = {};
    EffectInterpretor.__super__.constructor.apply(this, arguments);
  }

  EffectInterpretor.prototype.compact = function() {
    this.data = EffectInterpretor.__super__.compact.call(this, this.effect, {
      bypassDefaults: true
    });
    if (this.hasEffectProperties()) {
      this.interpretEffectProperties();
    }
    return this.data;
  };

  EffectInterpretor.prototype.hasEffectProperties = function() {
    return this.effect.numProperties > 0;
  };

  EffectInterpretor.prototype.interpretEffectProperties = function() {
    var effectPropertyInterpretor, i, j, propertyInterpreted, ref, results;
    this.data.properties = [];
    results = [];
    for (i = j = 1, ref = this.effect.numProperties; 1 <= ref ? j <= ref : j >= ref; i = 1 <= ref ? ++j : --j) {
      effectPropertyInterpretor = new Hyle.EffectPropertyInterpretor(this.effect.property(i));
      propertyInterpreted = effectPropertyInterpretor.compact();
      if (propertyInterpreted) {
        results.push(this.data.properties.push(propertyInterpreted));
      } else {
        results.push(void 0);
      }
    }
    return results;
  };

  return EffectInterpretor;

})(Hyle.Effect);
