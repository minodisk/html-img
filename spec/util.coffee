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
    editor = editorView.getEditor()
    runs ->
      editor.setCursorBufferPosition position
      editorView.trigger command
    waits 100
    runs ->
      expect(editor.getText()).toBe("#{expected}\n")
      { start } = editor.getSelectedBufferRange()
      expect(start.row).toBe(position[0])
      expect(start.column).toBe(position[1])
      editor.undo()
