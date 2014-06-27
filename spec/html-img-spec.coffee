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

  describe "in EJS", ->

    it "supports base-absolute", ->
      editorView = open 'htdocs/ejs/base-absolute.ejs'
      assert editorView, 'html-img:fill', '<img src="/images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" width="800" height="500">'
      assert editorView, 'html-img:fill-half', '<img src="/images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" width="400" height="250">'
      assert editorView, 'html-img:fill-width', '<img src="/images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" width="800">'
      assert editorView, 'html-img:fill-width-half', '<img src="/images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" width="400">'
      assert editorView, 'html-img:fill-height', '<img src="/images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" height="500">'
      assert editorView, 'html-img:fill-height-half', '<img src="/images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" height="250">'

    it "supports base-relative", ->
      editorView = open 'htdocs/ejs/base-relative.ejs'
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" width="800" height="500">'
      assert editorView, 'html-img:fill-half', '<img src="../images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" width="400" height="250">'
      assert editorView, 'html-img:fill-width', '<img src="../images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" width="800">'
      assert editorView, 'html-img:fill-width-half', '<img src="../images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" width="400">'
      assert editorView, 'html-img:fill-height', '<img src="../images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" height="500">'
      assert editorView, 'html-img:fill-height-half', '<img src="../images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" height="250">'

    it "supports protocol-absolute", ->
      editorView = open 'htdocs/ejs/protocol-absolute.ejs'
      assert editorView, 'html-img:fill', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" width="800" height="500">'
      assert editorView, 'html-img:fill-half', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" width="400" height="250">'
      assert editorView, 'html-img:fill-width', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" width="800">'
      assert editorView, 'html-img:fill-width-half', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" width="400">'
      assert editorView, 'html-img:fill-height', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" height="500">'
      assert editorView, 'html-img:fill-height-half', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" height="250">'

    it "supports protocol-relative", ->
      editorView = open 'htdocs/ejs/protocol-relative.ejs'
      assert editorView, 'html-img:fill', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" width="800" height="500">'
      assert editorView, 'html-img:fill-half', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" width="400" height="250">'
      assert editorView, 'html-img:fill-width', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" width="800">'
      assert editorView, 'html-img:fill-width-half', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" width="400">'
      assert editorView, 'html-img:fill-height', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" height="500">'
      assert editorView, 'html-img:fill-height-half', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" height="250">'

    it "recognizes tag range", ->
      editorView = open 'htdocs/ejs/tag-range.ejs'
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>"><img src="../images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>">', [0, 0]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" width="800" height="500"><img src="../images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>">', [0, 1]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" width="800" height="500"><img src="../images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>">', [0, 115]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>"><img src="../images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>">', [0, 116]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>"><img src="../images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" width="800" height="500">', [0, 117]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>"><img src="../images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" width="800" height="500">', [0, 231]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>"><img src="../images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>">', [0, 232]

    it "recognizes spaced tag", ->
      editorView = open 'htdocs/ejs/tag-spaced.ejs'
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>"\n  >', [0, 0]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>"\n  width="800" height="500">', [0, 1]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>"\n  width="800" height="500">', [1, 1]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>"\n  width="800" height="500">', [2, 1]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>"\n  width="800" height="500">', [3, 1]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>"\n  >', [4, 0]

    it "recognizes closed tag", ->
      editorView = open 'htdocs/ejs/tag-closed.ejs'
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if (foo < bar && bar > baz) { %><%= bar %><% } else { %><%- baz %><% } %>" width="800" height="500"/>'

  describe "in ECO", ->

    it "supports base-absolute", ->
      editorView = open 'htdocs/eco/base-absolute.eco'
      assert editorView, 'html-img:fill', '<img src="/images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" width="800" height="500">'
      assert editorView, 'html-img:fill-half', '<img src="/images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" width="400" height="250">'
      assert editorView, 'html-img:fill-width', '<img src="/images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" width="800">'
      assert editorView, 'html-img:fill-width-half', '<img src="/images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" width="400">'
      assert editorView, 'html-img:fill-height', '<img src="/images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" height="500">'
      assert editorView, 'html-img:fill-height-half', '<img src="/images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" height="250">'

    it "supports base-relative", ->
      editorView = open 'htdocs/eco/base-relative.eco'
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" width="800" height="500">'
      assert editorView, 'html-img:fill-half', '<img src="../images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" width="400" height="250">'
      assert editorView, 'html-img:fill-width', '<img src="../images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" width="800">'
      assert editorView, 'html-img:fill-width-half', '<img src="../images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" width="400">'
      assert editorView, 'html-img:fill-height', '<img src="../images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" height="500">'
      assert editorView, 'html-img:fill-height-half', '<img src="../images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" height="250">'

    it "supports protocol-absolute", ->
      editorView = open 'htdocs/eco/protocol-absolute.eco'
      assert editorView, 'html-img:fill', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" width="800" height="500">'
      assert editorView, 'html-img:fill-half', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" width="400" height="250">'
      assert editorView, 'html-img:fill-width', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" width="800">'
      assert editorView, 'html-img:fill-width-half', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" width="400">'
      assert editorView, 'html-img:fill-height', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" height="500">'
      assert editorView, 'html-img:fill-height-half', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" height="250">'

    it "supports protocol-relative", ->
      editorView = open 'htdocs/eco/protocol-relative.eco'
      assert editorView, 'html-img:fill', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" width="800" height="500">'
      assert editorView, 'html-img:fill-half', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" width="400" height="250">'
      assert editorView, 'html-img:fill-width', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" width="800">'
      assert editorView, 'html-img:fill-width-half', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" width="400">'
      assert editorView, 'html-img:fill-height', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" height="500">'
      assert editorView, 'html-img:fill-height-half', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" height="250">'

    it "recognizes tag range", ->
      editorView = open 'htdocs/eco/tag-range.eco'
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>"><img src="../images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>">', [0, 0]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" width="800" height="500"><img src="../images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>">', [0, 1]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" width="800" height="500"><img src="../images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>">', [0, 112]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>"><img src="../images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>">', [0, 113]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>"><img src="../images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" width="800" height="500">', [0, 114]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>"><img src="../images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" width="800" height="500">', [0, 225]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>"><img src="../images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>">', [0, 226]

    it "recognizes spaced tag", ->
      editorView = open 'htdocs/eco/tag-spaced.eco'
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>"\n  >', [0, 0]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>"\n  width="800" height="500">', [0, 1]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>"\n  width="800" height="500">', [1, 1]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>"\n  width="800" height="500">', [2, 1]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>"\n  width="800" height="500">', [3, 1]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>"\n  >', [4, 0]

    it "recognizes closed tag", ->
      editorView = open 'htdocs/eco/tag-closed.eco'
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if foo < bar and bar > baz: %><%= bar %><% else: %><%- baz %><% end %>" width="800" height="500"/>'

  describe "in ERB", ->

    it "supports base-absolute", ->
      editorView = open 'htdocs/erb/base-absolute.erb'
      assert editorView, 'html-img:fill', '<img src="/images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" width="800" height="500">'
      assert editorView, 'html-img:fill-half', '<img src="/images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" width="400" height="250">'
      assert editorView, 'html-img:fill-width', '<img src="/images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" width="800">'
      assert editorView, 'html-img:fill-width-half', '<img src="/images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" width="400">'
      assert editorView, 'html-img:fill-height', '<img src="/images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" height="500">'
      assert editorView, 'html-img:fill-height-half', '<img src="/images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" height="250">'

    it "supports base-relative", ->
      editorView = open 'htdocs/erb/base-relative.erb'
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" width="800" height="500">'
      assert editorView, 'html-img:fill-half', '<img src="../images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" width="400" height="250">'
      assert editorView, 'html-img:fill-width', '<img src="../images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" width="800">'
      assert editorView, 'html-img:fill-width-half', '<img src="../images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" width="400">'
      assert editorView, 'html-img:fill-height', '<img src="../images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" height="500">'
      assert editorView, 'html-img:fill-height-half', '<img src="../images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" height="250">'

    it "supports protocol-absolute", ->
      editorView = open 'htdocs/erb/protocol-absolute.erb'
      assert editorView, 'html-img:fill', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" width="800" height="500">'
      assert editorView, 'html-img:fill-half', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" width="400" height="250">'
      assert editorView, 'html-img:fill-width', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" width="800">'
      assert editorView, 'html-img:fill-width-half', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" width="400">'
      assert editorView, 'html-img:fill-height', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" height="500">'
      assert editorView, 'html-img:fill-height-half', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" height="250">'

    it "supports protocol-relative", ->
      editorView = open 'htdocs/erb/protocol-relative.erb'
      assert editorView, 'html-img:fill', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" width="800" height="500">'
      assert editorView, 'html-img:fill-half', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" width="400" height="250">'
      assert editorView, 'html-img:fill-width', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" width="800">'
      assert editorView, 'html-img:fill-width-half', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" width="400">'
      assert editorView, 'html-img:fill-height', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" height="500">'
      assert editorView, 'html-img:fill-height-half', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" height="250">'

    it "recognizes tag range", ->
      editorView = open 'htdocs/erb/tag-range.erb'
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>"><img src="../images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>">', [0, 0]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" width="800" height="500"><img src="../images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>">', [0, 1]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" width="800" height="500"><img src="../images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>">', [0, 114]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>"><img src="../images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>">', [0, 115]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>"><img src="../images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" width="800" height="500">', [0, 116]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>"><img src="../images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" width="800" height="500">', [0, 229]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>"><img src="../images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>">', [0, 230]

    it "recognizes spaced tag", ->
      editorView = open 'htdocs/erb/tag-spaced.erb'
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>"\n  >', [0, 0]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>"\n  width="800" height="500">', [0, 1]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>"\n  width="800" height="500">', [1, 1]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>"\n  width="800" height="500">', [2, 1]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>"\n  width="800" height="500">', [3, 1]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>"\n  >', [4, 0]

    it "recognizes closed tag", ->
      editorView = open 'htdocs/erb/tag-closed.erb'
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<% if foo < bar && bar > baz then %><%= bar %><% else %><%- baz %><% end %>" width="800" height="500"/>'
