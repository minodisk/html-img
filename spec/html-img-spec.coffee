path = require 'path'
fs = require 'fs'
{ inspect } = require 'util'
{ WorkspaceView } = require 'atom'


openFile = (filename) ->
  atom.workspaceView = new WorkspaceView
  atom.project.setPath path.join __dirname, 'fixtures'
  atom.workspaceView.openSync filename
  atom.workspaceView.attachToDom()
  editorView = atom.workspaceView.getActiveView()
  editor = editorView.getEditor()
  { editorView, editor }

loadGrammar = (grammar) ->
  languagePath = atom.packages.resolvePackagePath "language-#{grammar}"
  grammarsPath = path.resolve languagePath, 'grammars'
  for filename in fs.readdirSync grammarsPath
    atom.syntax.loadGrammarSync path.resolve grammarsPath, filename

activatePackage = (callback) ->
  activationPromise = atom.packages.activatePackage 'html-img'
  .then ({ mainModule }) ->
    callback mainModule.watchers[0]


describe "main", ->

  describe "when '.html' files are opened", ->

    [ editorView, editor, activationPromise, workspace, errorView, referenceView ] = []

    beforeEach ->
      { editorView, editor } = openFile 'path-url.html'
      loadGrammar 'html'
      activationPromise = activatePackage (w) ->
        workspace = w

    it "should support url", ->
      waitsForPromise ->
        activationPromise
      runs ->
        editor.setCursorBufferPosition [0, 1]
        editorView.trigger 'html-img:fill'
      waits 1000
      runs ->
        expect(editor.getText()).toBe('<img src="https://atom.io/assets/monitor-b3b60637a9422ab1e893c9c0820a53c2.png" width="410" height="342">\n')

  describe "when '.jade' files are opened", ->

    [ editorView, editor, activationPromise, workspace, errorView, referenceView ] = []

    beforeEach ->
      { editorView, editor } = openFile 'path-url.jade'
      loadGrammar 'jade'
      activationPromise = activatePackage (w) ->
        workspace = w

    it "should support url", ->
      waitsForPromise ->
        activationPromise
      runs ->
        editor.setCursorBufferPosition [0, 1]
        editorView.trigger 'html-img:fill'
      waits 1000
      runs ->
        expect(editor.getText()).toBe('img(src="https://atom.io/assets/monitor-b3b60637a9422ab1e893c9c0820a53c2.png", width="410", height="342")\n')
