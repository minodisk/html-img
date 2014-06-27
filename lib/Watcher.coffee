{ EventEmitter } = require 'events'
{ extname } = require 'path'
{ $, Point, Range } = require 'atom'
Languages = require './Languages'
Size = require './languages/helper/Size'
{ round } = Math


module.exports =
class Watcher extends EventEmitter


  WIDTH = 1
  HEIGHT = 2
  BOTH = WIDTH | HEIGHT


  # Life-cycle

  constructor: (@editorView, @languages) ->
    super()
    @languages = Languages.getInstance()
    @editor = @editorView.editor
    @editor.on 'grammar-changed', @checkGrammar
    @editor.on 'destroyed', @onDestroyed
    @checkGrammar()

  destruct: =>
    @removeAllListeners()
    @deactivate()
    @editor.off 'grammar-changed', @checkGrammar
    @editor.off 'destroyed', @onDestroyed

    delete @editorView
    delete @editor
    delete @languages

  onDestroyed: =>
    @emit 'destroyed', @


  # Enabled-disabled-cycle

  checkGrammar: =>
    language = @languages.getDefinition extname(@editor.getTitle()).replace(/^\./, '')
    if @language isnt language
      @deactivate()
      @activate language

  activate: (@language) ->
    return unless @language?

    # Start listening
    @editorView.on 'html-img:fill', @onFill
    @editorView.on 'html-img:fill-half', @onFillHalf
    @editorView.on 'html-img:fill-width', @onFillWidth
    @editorView.on 'html-img:fill-width-half', @onFillWidthHalf
    @editorView.on 'html-img:fill-height', @onFillHeight
    @editorView.on 'html-img:fill-height-half', @onFillHeightHalf

  deactivate: ->
    return unless @language?

    # Stop listening
    @editorView.off 'html-img:fill', @onFill
    @editorView.off 'html-img:fill-half', @onFillHalf
    @editorView.off 'html-img:fill-width', @onFillWidth
    @editorView.off 'html-img:fill-width-half', @onFillWidthHalf
    @editorView.off 'html-img:fill-height', @onFillHeight
    @editorView.off 'html-img:fill-height-half', @onFillHeightHalf

    # Remove references
    delete @language

  onFill: (e) =>
    # e.abortKeyBinding()
    @fill BOTH

  onFillHalf: (e) =>
    @fill BOTH, 0.5

  onFillWidth: (e) =>
    # e.abortKeyBinding()
    @fill WIDTH

  onFillWidthHalf: (e) =>
    # e.abortKeyBinding()
    @fill WIDTH, 0.5

  onFillHeight: (e) =>
    # e.abortKeyBinding()
    @fill HEIGHT

  onFillHeightHalf: (e) =>
    # e.abortKeyBinding()
    @fill HEIGHT, 0.5

  fill: (flag, scale = 1) ->
    filled = 0
    filling = @editor.cursors.length
    process = (node, position, $img) =>
      size = new Size
      if needsWidth
        size.width = round $img.width() * scale
      if needsHeight
        size.height = round $img.height() * scale
      text = @language.replace node, size
      if text?
        textBuffer.setTextInRange node.range, text
        cursor.setBufferPosition position
    onComplete = =>
      return unless ++filled is filling
      @emit 'complete'

    needsWidth = (flag & WIDTH) isnt 0
    needsHeight = (flag & HEIGHT) isnt 0
    textBuffer = @editor.buffer
    base = @editor.getUri()
    for cursor in @editor.cursors
      do (cursor) =>
        position = cursor.getBufferPosition()
        node = @language.find cursor, textBuffer

        # no target is found
        unless node?
          onComplete()
          return

        # ready to load image
        path = node.getPath base
        $img = $ '<img>'
        .attr 'src', path
        .hide()
        .appendTo @editorView.overlayer

        # with cache
        if $img[0].complete
          process node, position, $img
          $img.remove()
          onComplete()
          return

        # without cache
        # listen to error and load event
        $img
        .one 'error', (e) =>
          $img.remove()
          onComplete()
        .one 'load', =>
          process node, position, $img
          $img.remove()
          onComplete()
