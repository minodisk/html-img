{ dirname, resolve, join } = require 'path'
Project = require '../../Project'


module.exports =
class Node

  constructor: (@range, @text, src) ->
    @project = Project.getInstance()
    @src = src
    .replace /^\s+/, ''
    .replace /\s+$/, ''

  getPath: (base) ->
    src = @src

    if /^https?:\/{2}/.test src
      return src

    matched = src.match /^(\/+)/
    if matched? and (slashes = matched[1])?
      if slashes.length is 1
        return atom.project.resolve "#{@project.get('document_root')}#{src}"
      else
        return "#{@project.get('protocol')}:#{src}"
    else
      return resolve dirname(base), src
