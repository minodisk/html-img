{ open, assert } = require './util'


describe "html-img", ->

  describe "in Jade", ->

    it "supports base-absolute", ->
      editorView = open 'htdocs/jade/base-absolute.jade'
      assert editorView, 'html-img:fill', 'img(src="/images/example.png", width="800", height="500")'
      assert editorView, 'html-img:fill-half', 'img(src="/images/example.png", width="400", height="250")'
      assert editorView, 'html-img:fill-width', 'img(src="/images/example.png", width="800")'
      assert editorView, 'html-img:fill-width-half', 'img(src="/images/example.png", width="400")'
      assert editorView, 'html-img:fill-height', 'img(src="/images/example.png", height="500")'
      assert editorView, 'html-img:fill-height-half', 'img(src="/images/example.png", height="250")'

    it "supports base-relative", ->
      editorView = open 'htdocs/jade/base-relative.jade'
      assert editorView, 'html-img:fill', 'img(src="../images/example.png", width="800", height="500")'
      assert editorView, 'html-img:fill-half', 'img(src="../images/example.png", width="400", height="250")'
      assert editorView, 'html-img:fill-width', 'img(src="../images/example.png", width="800")'
      assert editorView, 'html-img:fill-width-half', 'img(src="../images/example.png", width="400")'
      assert editorView, 'html-img:fill-height', 'img(src="../images/example.png", height="500")'
      assert editorView, 'html-img:fill-height-half', 'img(src="../images/example.png", height="250")'

    it "supports protocol-absolute", ->
      editorView = open 'htdocs/jade/protocol-absolute.jade'
      assert editorView, 'html-img:fill', 'img(src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png", width="800", height="500")'
      assert editorView, 'html-img:fill-half', 'img(src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png", width="400", height="250")'
      assert editorView, 'html-img:fill-width', 'img(src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png", width="800")'
      assert editorView, 'html-img:fill-width-half', 'img(src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png", width="400")'
      assert editorView, 'html-img:fill-height', 'img(src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png", height="500")'
      assert editorView, 'html-img:fill-height-half', 'img(src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png", height="250")'

    it "supports protocol-relative", ->
      editorView = open 'htdocs/jade/protocol-relative.jade'
      assert editorView, 'html-img:fill', 'img(src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png", width="800", height="500")'
      assert editorView, 'html-img:fill-half', 'img(src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png", width="400", height="250")'
      assert editorView, 'html-img:fill-width', 'img(src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png", width="800")'
      assert editorView, 'html-img:fill-width-half', 'img(src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png", width="400")'
      assert editorView, 'html-img:fill-height', 'img(src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png", height="500")'
      assert editorView, 'html-img:fill-height-half', 'img(src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png", height="250")'

    it "recognizes spaced tag", ->
      editorView = open 'htdocs/jade/tag-spaced.jade'
      assert editorView, 'html-img:fill', 'img ( src = "../images/example.png", width="800", height="500")'
