{ join, resolve, extname } = require 'path'
{ readdirSync } = require 'fs'
{ WorkspaceView } = require 'atom'


module.exports =

  open: (file) ->
    atom.workspaceView = new WorkspaceView
    atom.project.setPath join __dirname, 'fixtures'
    atom.workspaceView.openSync file
    atom.workspaceView.attachToDom()
    editorView = atom.workspaceView.getActiveView()

    for lang in ['html', 'jade']
      languagePath = atom.packages.resolvePackagePath "language-#{lang}"
      grammarsPath = resolve languagePath, 'grammars'
      for grammarFile in readdirSync grammarsPath
        atom.syntax.loadGrammarSync resolve grammarsPath, grammarFile

    waitsForPromise -> atom.packages.activatePackage 'html-img'

    editorView

  assert: (editorView, command, expected, position = [0, 1]) ->
    isComplete = false
    editor = editorView.getEditor()
    runs ->
      pkg = atom.packages.getActivePackage 'html-img'
      watcher = pkg.mainModule.watchers[0]
      watcher.once 'complete', ->
        isComplete = true
      editor.setCursorBufferPosition position
      editorView.trigger command
    waitsFor ->
      isComplete
    , "filled", 3000
    runs ->
      expect(editor.getText()).toBe("#{expected}\n")
      { start } = editor.getSelectedBufferRange()
      expect(start.row).toBe(position[0])
      expect(start.column).toBe(position[1])
      editor.undo()
