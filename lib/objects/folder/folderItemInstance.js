// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Hyle.FolderItemInstance = (function(_super) {
  __extends(FolderItemInstance, _super);

  function FolderItemInstance(data) {
    this.ignoredProperties = ["parentFolder"];
    FolderItemInstance.__super__.constructor.apply(this, arguments);
    this.initiate(data);
  }

  FolderItemInstance.prototype.store = function() {
    return FolderItemInstance.__super__.store.call(this, app.project.items.addFolder(this.data.name));
  };

  return FolderItemInstance;

})(Hyle.FolderItem);