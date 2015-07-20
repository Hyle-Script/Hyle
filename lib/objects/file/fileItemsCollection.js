// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Hyle.FileItemsCollection = (function(_super) {
  __extends(FileItemsCollection, _super);

  function FileItemsCollection() {
    this.files = [];
  }

  FileItemsCollection.prototype.getFileObject = function(id) {
    return this.files[id];
  };

  FileItemsCollection.prototype.getFile = function(id) {
    if (this.getFileObject(id)) {
      return this.getFileObject(id).file;
    } else {
      return false;
    }
  };

  FileItemsCollection.prototype.getFileOrImport = function(id) {
    var file, fileData, path;
    if (this.getFile(id)) {
      return this.getFile(id);
    } else {
      path = id;
      fileData = {
        path: path,
        name: esy.file.fileName(path)
      };
      file = hyle.parser.fileItemsFactory.createFile(fileData);
      return file.item;
    }
  };

  FileItemsCollection.prototype.add = function(file) {
    var _base;
    (_base = file.item)._id || (_base._id = file.getFileName());
    return this.files[file.item._id] = file;
  };

  return FileItemsCollection;

})(Hyle.Collection);