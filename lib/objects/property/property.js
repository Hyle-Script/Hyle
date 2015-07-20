// Generated by CoffeeScript 1.7.1
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Hyle.Property = (function(_super) {
  __extends(Property, _super);

  function Property() {
    this.evalIfDirective = __bind(this.evalIfDirective, this);
    this.getEasingValue = __bind(this.getEasingValue, this);
    this.setTemporalEaseAtKey = __bind(this.setTemporalEaseAtKey, this);
  }

  Property.prototype.getPropertyName = function() {
    return this.propertyName;
  };

  Property.prototype.getPropertyValue = function() {
    return this.propertyValue;
  };

  Property.prototype.setValues = function(propertyAlias, propertyValue) {
    if (propertyValue.value) {
      this.setPropertyValue(propertyAlias, propertyValue.value);
    }
    if (propertyValue.expression) {
      this.setPropertyExpression(propertyAlias, propertyValue.expression);
    }
    if (propertyValue.keyframes) {
      this.setPropertyValueAtTime(propertyAlias, propertyValue.keyframes);
    }
    try {
      return this.setPropertyValue(propertyAlias, propertyValue);
    } catch (_error) {}
  };

  Property.prototype.setPropertyValue = function(propertyAlias, propertyValue) {
    try {
      return propertyAlias.setValue(propertyValue);
    } catch (_error) {}
  };

  Property.prototype.setPropertyExpression = function(propertyAlias, propertyExpression) {
    return propertyAlias.expression = propertyExpression;
  };

  Property.prototype.setPropertyValueAtTime = function(propertyAlias, keyframes) {
    var keyframe, previousKeyframe, timespan, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = keyframes.length; _i < _len; _i++) {
      keyframe = keyframes[_i];
      if (keyframe.time == null) {
        keyframe.time = keyframe[0];
      }
      keyframe.time = this.convertToFrameIfNeeded(keyframe.time);
      if (keyframe.value == null) {
        keyframe.value = keyframe[1];
      }
      propertyAlias.setValueAtTime(keyframe.time, keyframe.value);
      if (keyframe.easing) {
        if (previousKeyframe) {
          timespan = keyframe.time * 24 - previousKeyframe.time * 24;
          keyframe.value = keyframe.value - previousKeyframe.value;
        } else {
          timespan = 0;
        }
        this.setPropertyValueAtTimeEasing(propertyAlias, keyframe.easing, propertyAlias.numKeys, keyframe.value, timespan);
      }
      _results.push(previousKeyframe = keyframe);
    }
    return _results;
  };

  Property.prototype.validateInAndNotSameAsDefaults = function(defaults, key) {
    if (defaults.hasOwnProperty(this.propertyName)) {
      if (defaults[this.propertyName] !== this.propertyValue) {
        return true;
      }
    } else {
      return false;
    }
  };

  Property.prototype.setPropertyValueAtTimeEasing = function(propertyAlias, easingType, keyframeId, keyframeValue, timespan) {
    var easeIn, easeOut, easing, propertyValue, _i, _len;
    if (keyframeValue instanceof Array) {
      easing = null;
      easeIn = [];
      easeOut = [];
      for (_i = 0, _len = keyframeValue.length; _i < _len; _i++) {
        propertyValue = keyframeValue[_i];
        easing = this.getEasingValue(easingType, propertyValue, timespan);
        easeIn.push(easing.easeIn);
        easeOut.push(easing.easeOut);
      }
      if (easeIn.length < 3) {
        easeIn.push(easing.easeIn);
        easeOut.push(easing.easeOut);
      }
    } else {
      easing = this.getEasingValue(easingType, keyframeValue, timespan);
      easeIn = [easing.easeIn];
      easeOut = [easing.easeOut];
    }
    return this.setTemporalEaseAtKey(propertyAlias, keyframeId, easeIn, easeOut);
  };

  Property.prototype.setTemporalEaseAtKey = function(propertyAlias, keyframeId, easeIn, easeOut) {
    return propertyAlias.setTemporalEaseAtKey(keyframeId, easeIn, easeOut);
  };

  Property.prototype.getEasingValue = function(easingType, keyframeValue, timespan) {
    var easeIn, easeOut, easings;
    switch (easingType) {
      case "easy ease":
      case "easy":
        easeIn = new KeyframeEase(0, 33.3);
        easeOut = new KeyframeEase(0, 33.3);
        break;
      case "ease in":
      case "in":
        easeIn = new KeyframeEase(0, 33.3);
        easeOut = new KeyframeEase(keyframeValue * timespan / app.project.activeItem.frameRate, 33.3);
        break;
      case "ease out":
      case "out":
        easeIn = new KeyframeEase(keyframeValue * timespan / app.project.activeItem.frameRate, 33.3);
        easeOut = new KeyframeEase(0, 33.3);
    }
    easings = {
      easeIn: easeIn,
      easeOut: easeOut
    };
    return easings;
  };

  Property.prototype.evalIfDirective = function(propertyValue) {
    if (typeof propertyValue === "string") {
      propertyValue = propertyValue.replace(/(?:%%)(.+?)(?:%%)/g, function(match, p1) {
        return eval(p1);
      });
    }
    return propertyValue;
  };

  Property.prototype.convertToFrameIfNeeded = function(propertyValue) {
    var framerate, r, _ref;
    if (typeof propertyValue === "string") {
      if ((_ref = propertyValue.match(/\w+$/)[0]) === "f" || _ref === "frame" || _ref === "frames") {
        if (app.project.activeItem) {
          framerate = app.project.activeItem.frameRate;
        } else {
          framerate = 24;
        }
        r = parseInt(propertyValue.replace(/\w+[.!?]?$/, '')) / framerate;
      }
    } else {
      r = propertyValue;
    }
    return r;
  };

  Property.prototype.getPropertyNameTranslations = function(opts, dict) {
    var scope, translations, translationsArray;
    translations = {
      "global": [
        {
          o: "_id",
          t: ["id"]
        }, {
          o: "pixelAspect",
          t: ["pixel aspect"]
        }, {
          o: "parentFolder",
          t: ["folder", "parent folder"]
        }, {
          o: "valueAtTime",
          t: ["keyframes"]
        }, {
          o: "frameRate",
          t: ["frame rate"]
        }
      ],
      "layer": [
        {
          o: "sourceText",
          t: ["text"]
        }, {
          o: "blendingMode",
          t: ["blending mode"]
        }, {
          o: "motionBlur",
          t: ["motion blur"]
        }, {
          o: "trackMatteType",
          t: ["track matte"]
        }, {
          o: "parent",
          t: ["parent layer"]
        }, {
          o: "parentComp",
          t: ["comp", "composition", "parent composition"]
        }, {
          o: "guideLayer",
          t: ["guide layer", "guide"]
        }, {
          o: "adjustmentLayer",
          t: ["adjustment layer", "adjustment"]
        }, {
          o: "startTime",
          t: ["start time"]
        }, {
          o: "inPoint",
          t: ["in point"]
        }, {
          o: "outPoint",
          t: ["out point"]
        }, {
          o: "frameRate",
          t: ["frame rate"]
        }, {
          o: "fillColor",
          t: ["fill color"]
        }, {
          o: "threeDLayer",
          t: ["3d", "3D"]
        }, {
          o: "zRotation",
          t: ["z rotation", "rotation z"]
        }, {
          o: "enabled",
          t: ["visible"]
        }, {
          o: "timeRemapping",
          t: ["time remapping"]
        }, {
          o: "focusDistance",
          t: ["focus distance"]
        }, {
          o: "Point of Interest",
          t: ["point of interest"]
        }, {
          o: "depthOfField",
          t: ["depth of field"]
        }, {
          o: "blurLevel",
          t: ["blur level"]
        }, {
          o: "irisShape",
          t: ["iris shape"]
        }, {
          o: "irisRotation",
          t: ["iris rotation"]
        }, {
          o: "irisAspectRatio",
          t: ["iris aspect ratio"]
        }, {
          o: "irisDiffractionFringe",
          t: ["iris diffraction fringe"]
        }, {
          o: "highlightGain",
          t: ["highlight gain"]
        }, {
          o: "highlightThreshold",
          t: ["highlight threshold"]
        }, {
          o: "highlightSaturation",
          t: ["highlight saturation"]
        }, {
          o: "coneAngle",
          t: ["cone angle"]
        }, {
          o: "coneFeather",
          t: ["cone feather"]
        }, {
          o: "falloffDistance",
          t: ["falloff distance"]
        }, {
          o: "castsShadows",
          t: ["casts shadows"]
        }, {
          o: "shadowDarkness",
          t: ["shadow darkness"]
        }, {
          o: "shadowDiffusion",
          t: ["shadow diffusion"]
        }, {
          o: "anchorPoint",
          t: ["anchor point"]
        }, {
          o: "fontSize",
          t: ["font size"]
        }, {
          o: "fillColor",
          t: ["fill color", "font color"]
        }, {
          o: "strokeColor",
          t: ["stroke color"]
        }, {
          o: "strokeWidth",
          t: ["stroke width"]
        }, {
          o: "strokeOverFill",
          t: ["stroke over fill"]
        }, {
          o: "applyStroke",
          t: ["apply stroke"]
        }, {
          o: "applyFill",
          t: ["apply fill"]
        }
      ],
      "layer.light.options": [
        {
          o: "lightType",
          t: ["type"]
        }
      ],
      "layer.mask": [
        {
          o: "mask path",
          t: ["path"]
        }, {
          o: "maskFeather",
          t: ["feather"]
        }, {
          o: "maskOpacity",
          t: ["opacity"]
        }, {
          o: "maskExpansion",
          t: ["expansion"]
        }, {
          o: "maskMode",
          t: ["mode"]
        }
      ],
      "layer.effects": [
        {
          o: "blending mode",
          t: ["blending mode"]
        }
      ]
    };
    scope = opts.scope || "global";
    translationsArray = translations[scope] || [];
    if (opts.scope) {
      translationsArray = translationsArray.concat(translations["global"]);
    }
    return toDict(translationsArray, dict);
  };

  return Property;

})(Hyle.Object);