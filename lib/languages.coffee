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
      continue unless cls.find? and cls.replace?
      @defs[language] = cls

  getDefinition: (language) ->
    @defs[language]
