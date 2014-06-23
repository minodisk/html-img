{ Point, Range } = require 'atom'
Node = require './helper/Node'


module.exports =

  find: (cursor, textBuffer) ->
    current = cursor.getBufferPosition()
    rangeBefore = new Range new Point(0, 0), current
    rangeAfter = new Range current, textBuffer.getEndPosition()

    range = new Range
    textBuffer.backwardsScanInRange /</, rangeBefore, ({ range: { start } }) ->
      range.start = start
    textBuffer.scanInRange />/, rangeAfter, ({ range: { end } }) ->
      range.end = end
    return unless range.start? and range.end?

    textBefore = textBuffer.getTextInRange new Range range.start, current
    return if />/.test textBefore

    textAfter = textBuffer.getTextInRange new Range current, range.end
    return if /</.test textAfter

    text = textBefore + textAfter
    matched = text.match /<img.+?src=["'](.*?)["']/
    return unless (src = matched?[1])? and src isnt ''

    new Node range, text, src

  replace: ({ range, text }, { width, height }) ->
    if /width/.test text
      text = text.replace /width(?:=".*?")?/, "width=\"#{width}\""
    else
      text = text.replace /\s*(\/?>)$/, " width=\"#{width}\"$1"
    if /height/.test text
      text = text.replace /height(?:=".*?")?/, "height=\"#{height}\""
    else
      text = text.replace /\s*(\/?>)$/, " height=\"#{height}\"$1"

    text
