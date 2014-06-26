###
Grammar definition for html, ejs and eco.
###


{ Point, Range } = require 'atom'
Node = require './helper/Node'


module.exports =
class HTML

  @fileTypes: [
    'html'
  ]

  @range: (textBuffer, position) ->
    rangeBefore = new Range new Point(0, 0), position
    rangeAfter = new Range position, textBuffer.getEndPosition()

    [ rangeStart, rangeEnd ] = []

    textBuffer.backwardsScanInRange /<[\s\S]*?/, rangeBefore, ({ matchText, range: { start }, stop }) ->
      stop()
      return if />/.test matchText
      rangeStart = start
    return unless rangeStart?

    textBuffer.scanInRange /[\s\S]*?>/, rangeAfter, ({ matchText, range: { end }, stop }) ->
      stop()
      return if /</.test matchText
      rangeEnd = end
    return unless rangeEnd?

    new Range rangeStart, rangeEnd

  @node: (textBuffer, range) ->
    return unless range?
    node = textBuffer.getTextInRange range
    matched = node.match /<img\s[\s\S]*src\s*=\s*["'](.*?)["']/
    return unless (src = matched?[1])? and src isnt ''
    new Node range, node, src

  @find: (cursor, textBuffer) ->
    @node textBuffer, @range textBuffer, cursor.getBufferPosition()

  @replace: ({ range, text }, { width, height }) ->
    if width?
      if /width/.test text
        text = text.replace /width(?:=".*?")?/, "width=\"#{width}\""
      else
        text = text.replace /[ ]?(\/?>)$/, " width=\"#{width}\"$1"
    if height?
      if /height/.test text
        text = text.replace /height(?:=".*?")?/, "height=\"#{height}\""
      else
        text = text.replace /[ ]?(\/?>)$/, " height=\"#{height}\"$1"
    text
