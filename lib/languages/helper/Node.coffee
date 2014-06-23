{ dirname, resolve } = require 'path'


module.exports =
class Node

  constructor: (@range, @text, src) ->
    @src = src
    .replace /^\s+/, ''
    .replace /\s+$/, ''

  getPath: (base) ->
    src = @src

    if /^https?:\/{2}/.test src
      return src

    matched = src.match /^(\/+)/
    if matched?
      if matched[1].length is 1
        console.log atom.project.resolve ".#{src}"
        return atom.project.resolve ".#{src}"
      else
        return "https:#{src}"
    else
      return resolve dirname(base), src
