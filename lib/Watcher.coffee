{ EventEmitter } = require 'events'
{ extname } = require 'path'
{$} = require 'atom-space-pen-views'
{ Point, Range } = require 'atom'
Languages = require './Languages'
Size = require './languages/helper/Size'
{ round } = Math


module.exports =
class Watcher extends EventEmitter


  WIDTH = 1
  HEIGHT = 2
  BOTH = WIDTH | HEIGHT


  # Life-cycle

  constructor: (@editor, @languages) ->
    super()
    @languages = Languages.getInstance()
    @command_changeGrammar = @editor.onDidChangeGrammar @checkGrammar
    @command_destroyed = @editor.onDidDestroy @onDestroyed
    @checkGrammar()

  destruct: =>
    @removeAllListeners()
    @deactivate()
    @command_changeGrammar.dispose()
    @command_destroyed.dispose()

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
    @command_onFill = atom.commands.add('atom-text-editor', 'html-img:fill', @onFill)
    @command_onFillHalf = atom.commands.add('atom-text-editor', 'html-img:fill-half', @onFillHalf)
    @command_onFillWidth = atom.commands.add('atom-text-editor', 'html-img:fill-width', @onFillWidth)
    @command_onFillWidthHalf = atom.commands.add('atom-text-editor', 'html-img:fill-width-half', @onFillWidthHalf)
    @command_onFillHeight = atom.commands.add('atom-text-editor', 'html-img:fill-height', @onFillHeight)
    @command_onFillHeightHalf = atom.commands.add('atom-text-editor', 'html-img:fill-height-half', @onFillHeightHalf)

  deactivate: ->
    return unless @language?

    # Stop listening
    @command_onFill.dispose()
    @command_onFillHalf.dispose()
    @command_onFillWidth.dispose()
    @command_onFillWidthHalf.dispose()
    @command_onFillHeight.dispose()
    @command_onFillHeightHalf.dispose()

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
        size.width = round $img[0].naturalWidth * scale
      if needsHeight
        size.height = round $img[0].naturalHeight * scale
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
    base = @editor.getURI()
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
