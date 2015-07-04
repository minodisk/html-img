###
Grammar definition for html, ejs and eco.
###


{ Point, Range } = require 'atom'
Node = require './helper/Node'
HTML = require './html'


module.exports =
class EJS extends HTML

  @fileTypes: [
    'ejs'
    'erb'
    'eco'
  ]

  @rCode: /<%.*?%>/g

  @find: (cursor, textBuffer) ->
    position = cursor.getBufferPosition()

    wholeText = textBuffer.getText()
    wholeTextTemp = wholeText.replace @rCode, (str) ->
      replacer = ''
      i = str.length
      while i--
        replacer += ' '
      replacer

    range = null
    textBuffer.transact =>
      textBuffer.setText wholeTextTemp
      range = @range textBuffer, position
      textBuffer.setText wholeText
      cursor.setBufferPosition position

    @node textBuffer, range
