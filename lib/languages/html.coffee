###
Grammar definition for html, ejs and eco.
###


{ Point, Range } = require 'atom'
Node = require './helper/Node'


module.exports =

  fileTypes: [
    'html'
  ]

  find: (cursor, textBuffer) ->
    current = cursor.getBufferPosition()
    rangeBefore = new Range new Point(0, 0), current
    rangeAfter = new Range current, textBuffer.getEndPosition()

    # 1. Get whole text
    # 2. Replace ejs tags to white space
    # 3. Find start of node before the cursor
    # 4. Find end of node after the cursor
    # 5. Join before and after texts to one node
    [ rangeStart, rangeEnd ] = []
    isBreak = false
    textBuffer.backwardsScanInRange /<[\s\S]*?/, rangeBefore, ({ matchText, range: { start }, stop }) ->
      if />/.test matchText
        isBreak = true
        return
      rangeStart = start
      stop()
    return if isBreak
    textBuffer.scanInRange /[\s\S]*?>/, rangeAfter, ({ matchText, range: { end }, stop }) ->
      if /</.test matchText
        isBreak = true
        return
      rangeEnd = end
      stop()
    return if isBreak
    return unless rangeStart? and rangeEnd?
    range = new Range rangeStart, rangeEnd
    node = [
      textBuffer.getTextInRange new Range range.start, current
      textBuffer.getTextInRange new Range current, range.end
    ].join ''
    matched = node.match /<img\s[\s\S]*src\s*=\s*["'](.*?)["']/
    return unless (src = matched?[1])? and src isnt ''

    new Node range, node, src

  replace: ({ range, text }, { width, height }) ->
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
