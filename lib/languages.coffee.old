{ readdirSync, statSync } = require 'fs'
{ resolve, basename, extname } = require 'path'


module.exports =
class Languages

  isInternal = false
  instance = null


  @getInstance: ->
    return instance if instance?
    isInternal = true
    instance = new Languages
    isInternal = false
    instance


  constructor: ->
    return unless isInternal

    @defs = {}
    dir = resolve __dirname, 'languages'
    for file in readdirSync dir
      stats = statSync resolve dir, file
      continue unless stats.isFile()
      language = basename file, extname file
      try
        cls = require "./languages/#{language}"
      catch err
        continue
      unless cls.fileTypes? and cls.find? and cls.replace?
        throw new Error 'language should be implemented `fileTypes`, `find()` and `replace()`'
        continue
      for fileType in cls.fileTypes
        @defs[fileType] = cls

  getDefinition: (fileType) ->
    @defs[fileType]
