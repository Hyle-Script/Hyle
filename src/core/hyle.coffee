# --------------------------------------------------------------------------------
# class Hyle
# --------------------------------------------------------------------------------
class Hyle

# ---------------------------------------- #
#                                          #
#               APPLICATION                #
#                                          #
# ---------------------------------------- #

# ----------------------------------------
# initialize
# ----------------------------------------
  initialize: () ->

    @name     = "Hyle"
    @mail     = "s.lavoie.b@gmail.com"
    @version  = "1.3.0"

    @parser   = new Hyle.Parser
    @composer = new Hyle.Composer
    @debugger = new Hyle.Debugger
    @api      = new Hyle.Api

    if @debug then @selfBuild "/Applications/Adobe After Effects CC 2014/Scripts/Startup"
    if @debug then @selfBuild (new File($.fileName)).parent.parent.path


    @debugger.initialize()



# ----------------------------------------
# selfBuild
# ----------------------------------------
  selfBuild: (path) ->
    currentPath = (new File($.fileName)).parent.parent.path
    esy.file.buildExtendScript "#{currentPath}/lib/hyle.js", ["#{path}/hyle.jsx"]

# ----------------------------------------
# parse
# ----------------------------------------
  parse: (data) ->
    app.beginUndoGroup 'Hyle'
    @parser.parse data
    app.endUndoGroup()

# ----------------------------------------
# compose
# ----------------------------------------
  compose: () ->
    app.beginUndoGroup 'Hyle'
    @composer.compose()
    app.endUndoGroup()
