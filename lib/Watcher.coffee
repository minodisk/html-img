{ EventEmitter } = require 'events'
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
    @isActive = false
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
    @deactivate()
    language = @editor.getGrammar().name.toLowerCase()
    return unless (@language = @languages.getDefinition language)?
    @activate()

  activate: ->
    return if @isActive

    # Start listening
    @editorView.on 'html-img:fill', @onFill
    @editorView.on 'html-img:fill-half', @onFillHalf
    @editorView.on 'html-img:fill-width', @onFillWidth
    @editorView.on 'html-img:fill-width-half', @onFillWidthHalf
    @editorView.on 'html-img:fill-height', @onFillHeight
    @editorView.on 'html-img:fill-height-half', @onFillHeightHalf

  deactivate: ->
    return unless @isActive

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
    textBuffer = @editor.buffer
    base = @editor.getUri()
    for cursor in @editor.cursors
      node = @language.find cursor, textBuffer
      if node?
        do (node) =>
          path = node.getPath base
          $img = $ '<img>'
          .one 'load', =>
            size = new Size
            if (flag & WIDTH) isnt 0
              size.width = round $img.width() * scale
            if (flag & HEIGHT) isnt 0
              size.height = round $img.height() * scale
            text = @language.replace node, size
            if text?
              textBuffer.setTextInRange node.range, text
            $img.remove()
          .attr 'src', path
          .hide()
          .appendTo @editorView.overlayer
