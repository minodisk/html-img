{ open, assert } = require './util'


describe "html-img", ->

  describe "in HTML", ->

    it "supports base-absolute", ->
      editorView = open 'htdocs/html/base-absolute.html'
      assert editorView, 'html-img:fill', '<img src="/images/example.png" width="800" height="500">'
      assert editorView, 'html-img:fill-half', '<img src="/images/example.png" width="400" height="250">'
      assert editorView, 'html-img:fill-width', '<img src="/images/example.png" width="800">'
      assert editorView, 'html-img:fill-width-half', '<img src="/images/example.png" width="400">'
      assert editorView, 'html-img:fill-height', '<img src="/images/example.png" height="500">'
      assert editorView, 'html-img:fill-height-half', '<img src="/images/example.png" height="250">'

    it "supports base-relative", ->
      editorView = open 'htdocs/html/base-relative.html'
      assert editorView, 'html-img:fill', '<img src="../images/example.png" width="800" height="500">'
      assert editorView, 'html-img:fill-half', '<img src="../images/example.png" width="400" height="250">'
      assert editorView, 'html-img:fill-width', '<img src="../images/example.png" width="800">'
      assert editorView, 'html-img:fill-width-half', '<img src="../images/example.png" width="400">'
      assert editorView, 'html-img:fill-height', '<img src="../images/example.png" height="500">'
      assert editorView, 'html-img:fill-height-half', '<img src="../images/example.png" height="250">'

    it "supports protocol-absolute", ->
      editorView = open 'htdocs/html/protocol-absolute.html'
      assert editorView, 'html-img:fill', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" width="800" height="500">'
      assert editorView, 'html-img:fill-half', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" width="400" height="250">'
      assert editorView, 'html-img:fill-width', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" width="800">'
      assert editorView, 'html-img:fill-width-half', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" width="400">'
      assert editorView, 'html-img:fill-height', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" height="500">'
      assert editorView, 'html-img:fill-height-half', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" height="250">'

    it "supports protocol-relative", ->
      editorView = open 'htdocs/html/protocol-relative.html'
      assert editorView, 'html-img:fill', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" width="800" height="500">'
      assert editorView, 'html-img:fill-half', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" width="400" height="250">'
      assert editorView, 'html-img:fill-width', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" width="800">'
      assert editorView, 'html-img:fill-width-half', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" width="400">'
      assert editorView, 'html-img:fill-height', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" height="500">'
      assert editorView, 'html-img:fill-height-half', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" height="250">'

    it "recognizes tag range", ->
      editorView = open 'htdocs/html/tag-range.html'
      assert editorView, 'html-img:fill', '<img src="../images/example.png"><img src="../images/example.png">', [0, 0]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" width="800" height="500"><img src="../images/example.png">', [0, 1]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" width="800" height="500"><img src="../images/example.png">', [0, 32]
      assert editorView, 'html-img:fill', '<img src="../images/example.png"><img src="../images/example.png">', [0, 33]
      assert editorView, 'html-img:fill', '<img src="../images/example.png"><img src="../images/example.png" width="800" height="500">', [0, 34]
      assert editorView, 'html-img:fill', '<img src="../images/example.png"><img src="../images/example.png" width="800" height="500">', [0, 65]
      assert editorView, 'html-img:fill', '<img src="../images/example.png"><img src="../images/example.png">', [0, 66]

    it "recognizes spaced tag", ->
      editorView = open 'htdocs/html/tag-spaced.html'
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt = "foo"\n  >', [0, 0]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt = "foo"\n  width="800" height="500">', [0, 1]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt = "foo"\n  width="800" height="500">', [1, 1]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt = "foo"\n  width="800" height="500">', [2, 1]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt = "foo"\n  width="800" height="500">', [3, 1]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt = "foo"\n  >', [4, 0]

    it "recognizes closed tag", ->
      editorView = open 'htdocs/html/tag-closed.html'
      assert editorView, 'html-img:fill', '<img src="../images/example.png" width="800" height="500"/>'
