{ EventEmitter } = require 'events'
{ $, Point, Range } = require 'atom'
Size = require './languages/helper/Size'


module.exports =
class Watcher extends EventEmitter

  # Life-cycle

  constructor: (@editorView, @languages) ->
    super()
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
    grammar = @editor.getGrammar().name.toLowerCase()
    return unless (@language = @languages[grammar])?
    @activate()

  activate: ->
    return if @isActive

    # Start listening
    @editorView.on 'html-img:fill', @onFillTriggered
    @editorView.on 'html-img:fill-width', @onFillTriggered
    @editorView.on 'html-img:fill-height', @onFillTriggered

  deactivate: ->
    return unless @isActive

    # Stop listening
    @editorView.off 'html-img:fill', @onFillTriggered
    @editorView.off 'html-img:fill-width', @onFillTriggered
    @editorView.off 'html-img:fill-height', @onFillTriggered

    # Remove references
    delete @language

  onFillTriggered: =>
    textBuffer = @editor.buffer
    for cursor in @editor.cursors
      node = @language.find cursor, textBuffer
      if node?
        do (node) =>
          $img = $ '<img>'
          .one 'load', =>
            text = @language.replace node, new Size $img.width(), $img.height()
            if text?
              textBuffer.setTextInRange node.range, text
            $img.remove()
          .attr 'src', node.src
          .hide()
          .appendTo @editorView.overlayer
