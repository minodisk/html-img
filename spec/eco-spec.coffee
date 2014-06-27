{ open, assert } = require './util'


describe "html-img", ->

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
