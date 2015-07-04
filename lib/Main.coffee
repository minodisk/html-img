Watcher = require './Watcher'

module.exports =
class Main

  renameCommand: ''
  doneCommand: ''

  config:
    highlightError:
      type: 'boolean'
      default: true
    highlightReference:
      type: 'boolean'
      default: true


  ###
  Life cycle
  ###

  activate: (state) ->
    @watchers = []

    atom.workspace.observeTextEditors (editor) => @onCreated(editor)
    @command_rename = atom.commands.add 'atom-workspace',
      @renameCommand
      @onRename
    @command_add = atom.commands.add 'atom-workspace',
      @doneCommand
      @onDone

  deactivate: ->
    @command_rename.dispose()
    @command_add.dispose()

    for watcher in @watchers
      watcher.destruct()
    delete @watchers

  serialize: ->


  ###
  Events
  ###

  onCreated: (editor) =>
    watcher = new Watcher editor
    watcher.on 'destroyed', @onDestroyed
    @watchers.push watcher

  onDestroyed: (watcher) =>
    watcher.destruct()
    @watchers.splice @watchers.indexOf(watcher), 1

  onRename: (e) =>
    isExecuted = false
    for watcher in @watchers
      isExecuted or= watcher.rename()
    return if isExecuted
    e.abortKeyBinding()

  onDone: (e) =>
    isExecuted = false
    for watcher in @watchers
      isExecuted or= watcher.done()
    return if isExecuted
    e.abortKeyBinding()
