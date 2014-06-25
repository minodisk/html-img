###
Grammar definition for html, ejs and eco.
###


{ Point, Range } = require 'atom'
Node = require './helper/Node'


module.exports =

  fileTypes: [
    'ejs'
    'erb'
    'eco'
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
    wholeText = textBuffer.getText()
    wholeTextTemp = wholeText.replace /<%.*?%>/g, (str) ->
      replacer = ''
      i = str.length
      while i--
        replacer += ' '
      replacer
    textBuffer.setText wholeTextTemp
    range = new Range
    textBuffer.backwardsScanInRange /<[^%]/, rangeBefore, ({ range: { start } }) ->
      range.start = start
    textBuffer.scanInRange /[^%]>/, rangeAfter, ({ match, range: { end } }) ->
      range.end = end
    textBuffer.setText wholeText
    return unless range.start? and range.end?
    nodeBefore = textBuffer.getTextInRange new Range range.start, current
    nodeAfter = textBuffer.getTextInRange new Range current, range.end
    node = nodeBefore + nodeAfter

    # Find source
    matched = node.match /<img.+?src=["'](.*?)["']/
    return unless (src = matched?[1])? and src isnt ''
    new Node range, node, src

  replace: ({ range, text }, { width, height }) ->
    if width?
      if /width/.test text
        text = text.replace /width(?:=".*?")?/, "width=\"#{width}\""
      else
        text = text.replace /\s*(\/?>)$/, " width=\"#{width}\"$1"
    if height?
      if /height/.test text
        text = text.replace /height(?:=".*?")?/, "height=\"#{height}\""
      else
        text = text.replace /\s*(\/?>)$/, " height=\"#{height}\"$1"
    text
