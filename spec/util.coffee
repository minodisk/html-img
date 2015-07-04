module.exports =

  open: (file) ->
    atom.project.setPaths [__dirname + '/fixtures']
    waitsForPromise -> atom.packages.activatePackage 'html-img'
    waitsForPromise -> atom.workspace.open(file)

  assert: (editorView, command, expected, position = [0, 1]) ->
    isComplete = false
    runs =>
      pkg = atom.packages.getActivePackage 'html-img'
      @editor = atom.workspace.getActiveTextEditor()
      watcher = pkg.mainModule.watchers[0]
      watcher.once 'complete', ->
        isComplete = true
      editor = @editor
      editor.setCursorBufferPosition position
      atom.commands.dispatch(atom.views.getView(editor), command)
    waitsFor ->
      isComplete
    , "filled", 3000
    runs =>
      editor = @editor
      expect(editor.getText()).toBe("#{expected}\n")
      { start } = editor.getSelectedBufferRange()
      expect(start.row).toBe(position[0])
      expect(start.column).toBe(position[1])
      editor.undo()
