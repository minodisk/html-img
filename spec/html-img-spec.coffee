{ join, resolve, extname } = require 'path'
{ readdirSync } = require 'fs'
{ inspect } = require 'util'
{ WorkspaceView } = require 'atom'


openFile = (filename) ->
  atom.workspaceView = new WorkspaceView
  atom.project.setPath join __dirname, 'fixtures'
  atom.workspaceView.openSync filename
  atom.workspaceView.attachToDom()
  editorView = atom.workspaceView.getActiveView()
  editor = editorView.getEditor()
  { editorView, editor }

loadGrammar = (grammar) ->
  languagePath = atom.packages.resolvePackagePath "language-#{grammar}"
  grammarsPath = resolve languagePath, 'grammars'
  for filename in readdirSync grammarsPath
    atom.syntax.loadGrammarSync resolve grammarsPath, filename

activatePackage = (name, callback) ->
  activationPromise = atom.packages.activatePackage name
  .then ({ mainModule }) ->
    callback? mainModule.watchers[0]

assert = (file, command, expected) ->
  [ workspace ] = []
  { editorView, editor } = openFile file
  loadGrammar extname(file).replace(/^\./, '')
  waitsForPromise -> activatePackage 'html-img'
  runs ->
    editor.setCursorBufferPosition [0, 1]
    editorView.trigger command
  waits 100
  runs ->
    expect(editor.getText()).toBe("#{expected}\n")
    editor.undo()



describe "html-img", ->

  describe "in HTML", ->

    it "supports base-absolute", ->
      assert 'htdocs/html/base-absolute.html', 'html-img:fill', '<img src="/images/example.png" width="800" height="500">'
      assert 'htdocs/html/base-absolute.html', 'html-img:fill-width', '<img src="/images/example.png" width="800">'
      assert 'htdocs/html/base-absolute.html', 'html-img:fill-height', '<img src="/images/example.png" height="500">'

    it "supports base-relative", ->
      assert 'htdocs/html/base-relative.html', 'html-img:fill', '<img src="../images/example.png" width="800" height="500">'
      assert 'htdocs/html/base-relative.html', 'html-img:fill-width', '<img src="../images/example.png" width="800">'
      assert 'htdocs/html/base-relative.html', 'html-img:fill-height', '<img src="../images/example.png" height="500">'

    it "supports protocol-absolute", ->
      assert 'htdocs/html/protocol-absolute.html', 'html-img:fill', '<img src="https://atom.io/assets/monitor-b3b60637a9422ab1e893c9c0820a53c2.png" width="410" height="342">'
      assert 'htdocs/html/protocol-absolute.html', 'html-img:fill-width', '<img src="https://atom.io/assets/monitor-b3b60637a9422ab1e893c9c0820a53c2.png" width="410">'
      assert 'htdocs/html/protocol-absolute.html', 'html-img:fill-height', '<img src="https://atom.io/assets/monitor-b3b60637a9422ab1e893c9c0820a53c2.png" height="342">'

    it "supports protocol-relative", ->
      assert 'htdocs/html/protocol-relative.html', 'html-img:fill', '<img src="//atom.io/assets/monitor-b3b60637a9422ab1e893c9c0820a53c2.png" width="410" height="342">'
      assert 'htdocs/html/protocol-relative.html', 'html-img:fill-width', '<img src="//atom.io/assets/monitor-b3b60637a9422ab1e893c9c0820a53c2.png" width="410">'
      assert 'htdocs/html/protocol-relative.html', 'html-img:fill-height', '<img src="//atom.io/assets/monitor-b3b60637a9422ab1e893c9c0820a53c2.png" height="342">'

  describe "in Jade", ->

    it "supports base-absolute", ->
      assert 'htdocs/jade/base-absolute.jade', 'html-img:fill', 'img(src="/images/example.png", width="800", height="500")'
      assert 'htdocs/jade/base-absolute.jade', 'html-img:fill-width', 'img(src="/images/example.png", width="800")'
      assert 'htdocs/jade/base-absolute.jade', 'html-img:fill-height', 'img(src="/images/example.png", height="500")'

    it "supports base-relative", ->
      assert 'htdocs/jade/base-relative.jade', 'html-img:fill', 'img(src="../images/example.png", width="800", height="500")'
      assert 'htdocs/jade/base-relative.jade', 'html-img:fill-width', 'img(src="../images/example.png", width="800")'
      assert 'htdocs/jade/base-relative.jade', 'html-img:fill-height', 'img(src="../images/example.png", height="500")'

    it "supports protocol-absolute", ->
      assert 'htdocs/jade/protocol-absolute.jade', 'html-img:fill', 'img(src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png", width="800", height="500")'
      assert 'htdocs/jade/protocol-absolute.jade', 'html-img:fill-width', 'img(src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png", width="800")'
      assert 'htdocs/jade/protocol-absolute.jade', 'html-img:fill-height', 'img(src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png", height="500")'

    it "supports protocol-relative", ->
      assert 'htdocs/jade/protocol-relative.jade', 'html-img:fill', 'img(src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png", width="800", height="500")'
      assert 'htdocs/jade/protocol-relative.jade', 'html-img:fill-width', 'img(src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png", width="800")'
      assert 'htdocs/jade/protocol-relative.jade', 'html-img:fill-height', 'img(src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png", height="500")'
