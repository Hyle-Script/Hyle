// Generated by CoffeeScript 1.10.0
var indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

Hyle.Object = (function() {
  function Object() {}

  Object.prototype.extend = function(sourceObject, defaultObject, adapt) {
    var property, propertyName, propertyValue;
    if (adapt == null) {
      adapt = false;
    }
    for (propertyName in defaultObject) {
      propertyValue = defaultObject[propertyName];
      if (sourceObject[propertyName]) {
        propertyValue = sourceObject[propertyName];
      }
      property = new Hyle.PropertyInstance(propertyName, propertyValue);
      property = property.adapt();
      if (!sourceObject[property.getPropertyName()]) {
        sourceObject[property.getPropertyName()] = property.getPropertyValue();
      }
    }
    return sourceObject;
  };

  Object.prototype.apply = function(object, data, adapt) {
    var property, propertyName, propertyValue;
    if (adapt == null) {
      adapt = false;
    }
    for (propertyName in data) {
      propertyValue = data[propertyName];
      if (indexOf.call(this.ignoredProperties, propertyName) < 0) {
        property = new Hyle.PropertyInstance(propertyName, propertyValue);
        if (adapt) {
          property.adapt();
        }
        try {
          property.apply(object);
        } catch (undefined) {}
      }
    }
    return object;
  };

  Object.prototype.adaptObject = function(objectData, opts) {
    var property, propertyName, propertyValue;
    if (opts == null) {
      opts = {};
    }
    for (propertyName in objectData) {
      propertyValue = objectData[propertyName];
      property = new Hyle.PropertyInstance(propertyName, propertyValue);
      property = property.adapt(opts);
      delete objectData[propertyName];
      objectData[property.getPropertyName()] = property.getPropertyValue();
    }
    return objectData;
  };

  Object.prototype.buffer = function(target, propertyName) {
    var bufferCounter, r;
    bufferCounter = 0;
    r = function() {
      if (target[propertyName]) {
        return true;
      } else {
        if (bufferCounter < 10) {
          bufferCounter++;
          $.sleep(100);
          return r();
        } else {
          return false;
        }
      }
    };
    return r();
  };

  Object.prototype.compact = function(object, opts) {
    var data, e, error, key, propertyInterpretor, value;
    if (opts == null) {
      opts = {};
    }
    data = {};
    if (this.validateNotIgnoredItem(object)) {
      for (key in object) {
        try {
          value = object[key];
        } catch (undefined) {}
        try {
          if (value && typeof object[key] !== "function") {
            if (indexOf.call(this.ignoredProperties, key) < 0) {
              propertyInterpretor = new Hyle.PropertyInterpretor(key, value);
              if (propertyInterpretor.validateNotInIgnoredValues(this.ignoredValues)) {
                if (opts.bypassDefaults === true || propertyInterpretor.validateInAndNotSameAsDefaults(this.defaults)) {
                  propertyInterpretor.adapt();
                  data[propertyInterpretor.getPropertyName()] = propertyInterpretor.getStringifiedPropertyValue();
                }
              }
            }
          }
        } catch (error) {
          e = error;
          logError(e);
        }
      }
      return data;
    } else {
      return false;
    }
  };

  Object.prototype.validateNotIgnoredItem = function(object) {
    var key, r;
    r = true;
    if (this.ignoredItems) {
      for (key in this.ignoredItems) {
        if (object[key] === this.ignoredItems[key]) {
          r = false;
        }
      }
    }
    return r;
  };

  return Object;

})();
