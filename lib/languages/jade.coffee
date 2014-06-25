###
Grammar definition for jade.
http://jade-lang.com/
###


{ Point, Range } = require 'atom'
Node = require './helper/Node'


module.exports =

  fileTypes: [
    'jade'
  ]

  find: (cursor, textBuffer) ->
    row = cursor.getBufferRow()
    range = textBuffer.rangeForRow row, false
    text = textBuffer.lineForRow row

    matched = text.match /img\s*\(.*src\s*=\s*["'](.*?)["']/
    return unless (src = matched?[1])? and src isnt ''

    new Node range, text, src

  replace: ({ range, text }, { width, height }) ->
    if width?
      if /width/.test text
        text = text.replace /width(?:=["'].*?["'])?/, "width=\"#{width}\""
      else
        text = text.replace /,?\s*\)/, ", width=\"#{width}\")"
    if height?
      if /height/.test text
        text = text.replace /height(?:=["'].*?["'])?/, "height=\"#{height}\""
      else
        text = text.replace /,?\s*\)$/, ", height=\"#{height}\")"
    text
