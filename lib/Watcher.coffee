{ EventEmitter } = require 'events'
{ $, Point, Range } = require 'atom'

module.exports =
class Watcher extends EventEmitter

  names: [
    'HTML'
    'Jade'
  ]

  constructor: (@editorView) ->
    super()
    @isActive = false
    @editor = @editorView.editor
    @editor.on 'grammar-changed', @checkGrammar
    @checkGrammar()

  destruct: =>
    @removeAllListeners()
    @deactivate()
    @editor.off 'grammar-changed', @checkGrammar

    delete @editorView
    delete @editor

  onDestroyed: =>
    @emit 'destroyed', @


  ###
  Grammar checker
  1. Detect grammar changed.
  2. Destroy instances and listeners.
  3. Exit when grammar isn't CoffeeScript.
  4. Create instances and listeners.
  ###

  checkGrammar: =>
    @deactivate()
    return unless @editor.getGrammar().name in @names
    @activate()

  activate: ->
    return if @isActive

    # Start listening
    @editor.on 'destroyed', @onDestroyed
    @editorView.on 'html-img:fill', @fillCursor
    @editorView.on 'html-img:fill-width', @fillAttribute
    @editorView.on 'html-img:fill-height', @fillAttribute

  deactivate: ->
    return unless @isActive

    # Stop listening
    @editor.off 'destroyed', @onDestroyed

    # Destruct instances

    # Remove references


  ###
  Reference finder process
  1. Stop listening cursor move event and reset views.
  2. Parse.
  3. Show errors and exit process when compile error is thrown.
  4. Show references.
  5. Start listening cursor move event.
  ###

  fillCursor: =>
    textBuffer = @editor.buffer
    startPosition = new Point 0, 0
    endPosition = textBuffer.getEndPosition()
    for cursor in @editor.cursors
      do (cursor) =>
        current = cursor.getBufferPosition()
        rangeBefore = new Range startPosition, current
        rangeAfter = new Range current, endPosition
        [ pointStart, pointEnd ] = []
        textBuffer.backwardsScanInRange /</, rangeBefore, ({ range }) ->
          pointStart = range.start
        textBuffer.scanInRange />/, rangeAfter, ({ range }) ->
          pointEnd = range.end
        return unless pointStart? and pointEnd?
        textBefore = textBuffer.getTextInRange new Range pointStart, current
        return if />/.test textBefore
        textAfter = textBuffer.getTextInRange new Range current, pointEnd
        return if /</.test textAfter
        text = textBefore + textAfter
        matched = text.match /<img.+?src="(.*?)"/
        return unless (src = matched?[1])? and src isnt ''
        $img = $ '<img>'
        .one 'load', =>
          width = $img.width()
          height = $img.height()
          console.log width, height
          range = new Range pointStart, pointEnd
          if /width/.test text
            text = text.replace /width(?:=".*?")?/, "width=\"#{width}\""
          else
            text = text.replace /\s*(\/?>)$/, " width=\"#{width}\"$1"
          if /height/.test text
            text = text.replace /height(?:=".*?")?/, "height=\"#{height}\""
          else
            text = text.replace /\s*(\/?>)$/, " height=\"#{height}\"$1"
          console.log range, text
          textBuffer.setTextInRange range, text
          $img.remove()
        .attr 'src', src
        .hide()
        .appendTo @editorView.overlayer


      # line = @editor.getText()
      # console.log position.row #, line.match /(?:width|height)=".*?"/

  fillAttribute: (e) =>
    [ {}, side ] = e.type.split ':'
