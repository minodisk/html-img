{ dirname, resolve } = require 'path'


module.exports =
class Node

  constructor: (@range, @text, @src) ->

  getPath: (base) ->
    src = @src.replace(/^\s+/, '').replace(/\s+$/, '')
    unless /^https?:\/{2}/.test src
      if /^\/{2}/.test src
        src = "https:#{src}"
      else if /^\//.test src
        console.log atom.project.resolve ".#{src}"
        src = atom.project.resolve ".#{src}"
      else
        src = resolve dirname(base), src
    @src = src
