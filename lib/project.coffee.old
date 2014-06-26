{ existsSync, readFileSync } = require 'fs'
{ assign } = require 'lodash'


module.exports =
class Project

  isInternal = false
  instance = null


  @getInstance: ->
    return instance if instance?
    isInternal = true
    instance = new Project
    isInternal = false
    instance


  constructor: ->
    pathJson = atom.project.resolve 'project.json'
    if existsSync pathJson
      data = JSON.parse readFileSync pathJson

    @data = assign
      document_root: ''
      protocol: 'http'
    , data

  get: (key) ->
    @data[key]
