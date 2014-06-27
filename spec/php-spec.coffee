{ open, assert } = require './util'


describe "html-img", ->

  describe "in EJS", ->

    it "supports base-absolute", ->
      editorView = open 'htdocs/php/base-absolute.php'
      assert editorView, 'html-img:fill', '<img src="/images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" width="800" height="500">'
      assert editorView, 'html-img:fill-half', '<img src="/images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" width="400" height="250">'
      assert editorView, 'html-img:fill-width', '<img src="/images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" width="800">'
      assert editorView, 'html-img:fill-width-half', '<img src="/images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" width="400">'
      assert editorView, 'html-img:fill-height', '<img src="/images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" height="500">'
      assert editorView, 'html-img:fill-height-half', '<img src="/images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" height="250">'

    it "supports base-relative", ->
      editorView = open 'htdocs/php/base-relative.php'
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" width="800" height="500">'
      assert editorView, 'html-img:fill-half', '<img src="../images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" width="400" height="250">'
      assert editorView, 'html-img:fill-width', '<img src="../images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" width="800">'
      assert editorView, 'html-img:fill-width-half', '<img src="../images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" width="400">'
      assert editorView, 'html-img:fill-height', '<img src="../images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" height="500">'
      assert editorView, 'html-img:fill-height-half', '<img src="../images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" height="250">'

    it "supports protocol-absolute", ->
      editorView = open 'htdocs/php/protocol-absolute.php'
      assert editorView, 'html-img:fill', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" width="800" height="500">'
      assert editorView, 'html-img:fill-half', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" width="400" height="250">'
      assert editorView, 'html-img:fill-width', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" width="800">'
      assert editorView, 'html-img:fill-width-half', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" width="400">'
      assert editorView, 'html-img:fill-height', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" height="500">'
      assert editorView, 'html-img:fill-height-half', '<img src="https://cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" height="250">'

    it "supports protocol-relative", ->
      editorView = open 'htdocs/php/protocol-relative.php'
      assert editorView, 'html-img:fill', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" width="800" height="500">'
      assert editorView, 'html-img:fill-half', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" width="400" height="250">'
      assert editorView, 'html-img:fill-width', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" width="800">'
      assert editorView, 'html-img:fill-width-half', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" width="400">'
      assert editorView, 'html-img:fill-height', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" height="500">'
      assert editorView, 'html-img:fill-height-half', '<img src="//cloud.githubusercontent.com/assets/514164/3367904/47f2f0ce-fb6b-11e3-9b0e-8f836f031d85.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" height="250">'

    it "recognizes tag range", ->
      editorView = open 'htdocs/php/tag-range.php'
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>"><img src="../images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>">', [0, 0]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" width="800" height="500"><img src="../images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>">', [0, 1]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" width="800" height="500"><img src="../images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>">', [0, 115]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>"><img src="../images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>">', [0, 116]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>"><img src="../images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" width="800" height="500">', [0, 117]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>"><img src="../images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" width="800" height="500">', [0, 231]
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>"><img src="../images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>">', [0, 232]

    it "recognizes spaced tag", ->
      editorView = open 'htdocs/php/tag-spaced.php'
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>"\n  >', [0, 0]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>"\n  width="800" height="500">', [0, 1]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>"\n  width="800" height="500">', [1, 1]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>"\n  width="800" height="500">', [2, 1]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>"\n  width="800" height="500">', [3, 1]
      assert editorView, 'html-img:fill', '<img\n  src = "../images/example.png"\n  alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>"\n  >', [4, 0]

    it "recognizes closed tag", ->
      editorView = open 'htdocs/php/tag-closed.php'
      assert editorView, 'html-img:fill', '<img src="../images/example.png" alt="<?php if ($foo < $bar && $bar > $baz) { ?>$bar<?php } else { ?>baz<?php } ?>" width="800" height="500"/>'
