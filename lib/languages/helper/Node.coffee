module.exports =
class Node

  constructor: (@range, @text, src) ->
    src = src.replace(/^\s+/, '').replace(/\s+$/, '')
    unless /^https?:\/{2}/.test src
      if /^\/{2}/.test src
        src = "https:#{src}"
      else if /^\//.test src
        src = atom.project.resolve "./#{src.substr 1}"
      else
        src = atom.project.resolve src
    @src = src
