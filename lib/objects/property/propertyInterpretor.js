// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Hyle.PropertyInterpretor = (function(_super) {
  __extends(PropertyInterpretor, _super);

  function PropertyInterpretor(propertyName, propertyValue) {
    var _ref;
    this.propertyName = propertyName;
    if (isObjectAndNotArray(propertyValue)) {
      propertyValue = (_ref = propertyValue.name) != null ? _ref : propertyValue.id;
    }
    this.propertyValue = propertyValue;
    PropertyInterpretor.__super__.constructor.apply(this, arguments);
    this;
  }

  PropertyInterpretor.prototype.getPropertyName = function() {
    return this.propertyName;
  };

  PropertyInterpretor.prototype.getPropertyValue = function() {
    return this.propertyValue;
  };

  PropertyInterpretor.prototype.getStringifiedPropertyValue = function() {
    var response;
    response = this.propertyValue;
    if (this.propertyValue instanceof FolderItem || this.propertyValue instanceof CompItem || this.propertyValue instanceof FootageItem || this.propertyValue instanceof Layer) {
      response = this.propertyValue.name;
    }
    return response;
  };

  PropertyInterpretor.prototype.validateNotInIgnoredValues = function(ignoredValues) {
    if ((ignoredValues != null ? ignoredValues[this.propertyName] : void 0) !== this.propertyValue) {
      return true;
    } else {
      return false;
    }
  };

  PropertyInterpretor.prototype.adapt = function(opts) {
    if (opts == null) {
      opts = {};
    }
    this.propertyName = this.adaptPropertyName(this.propertyName, opts);
    this.propertyValue = this.adaptPropertyValue(this.propertyName, this.propertyValue, opts);
    return this;
  };

  PropertyInterpretor.prototype.adaptPropertyName = function(propertyName, opts) {
    var propertyNamesTranslations, translatedPropertyName, _ref;
    propertyNamesTranslations = this.getPropertyNameTranslations(opts, "o");
    translatedPropertyName = ((_ref = propertyNamesTranslations[propertyName]) != null ? _ref["t"] : void 0) || propertyName;
    if (translatedPropertyName instanceof Array) {
      translatedPropertyName = translatedPropertyName[0];
    }
    return translatedPropertyName;
  };

  PropertyInterpretor.prototype.adaptPropertyValue = function(propertyName, propertyValue, opts) {
    if (propertyValue) {
      propertyValue = this.evalIfDirective(propertyValue);
      propertyValue = this.makeValueReplacements(propertyName, propertyValue);
    }
    return propertyValue;
  };

  PropertyInterpretor.prototype.makeValueReplacements = function(propertyName, propertyValue, opts) {
    var r;
    r = propertyValue;
    switch (propertyName.toLowerCase()) {
      case "color":
      case "color 1":
      case "fillcolor":
      case "color 2":
      case "color 3":
      case "color 4":
      case "color 5":
      case "map black to":
      case "map white to":
      case "tint color":
      case "shadows unbalance":
      case "midtones unbalance":
      case "highlights unbalance":
      case "highlights":
      case "brights":
      case "midtones":
      case "darktones":
      case "shadows":
      case "color to change":
        r = esy.color.rgbToHex(propertyValue);
        break;
      case "outpoint":
      case "inpoint":
      case "duration":
        r = Math.round(propertyValue * 10) / 10;
    }
    return r;
  };

  return PropertyInterpretor;

})(Hyle.Property);