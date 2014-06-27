# html-img package [![Build Status](https://travis-ci.org/minodisk/html-img.svg?branch=master)](https://travis-ci.org/minodisk/html-img)

Fill image size automatically.

![take-8](https://cloud.githubusercontent.com/assets/514164/3386329/338f2752-fc73-11e3-9aac-4a9f7b0e4312.gif)

* Supports HTML, [Jade](http://jade-lang.com/), [EJS](http://embeddedjs.com/), [ECO](https://github.com/sstephenson/eco), ERB and [PHP](http://www.php.net/)
* Supports png, jpg and gif
* Supports absolute url: Like `/images/sample.png` (requires `document_root` property in [project.json](#projectjson))
* Supports relative url: Like `images/smaple.png`
* Supports protocol-absolute url: Like `http://example.com/images/sample.png`
* Supports protocol-relative url: Like `//example.com/images/sample.png` (requires `protocol` property in [project.json](#projectjson))
* Fills only width, height or both
* Fills as full or half size
* Overwrites wrong size

[Changelog](https://github.com/minodisk/html-img/blob/master/CHANGELOG.md)

## Keymap

* `ctrl-i` or `ctrl-i enter`: Fill width and height
* `ctrl-i /`: Fill width and height as half
* `ctrl-alt-i` or `ctrl-alt-i enter`: Fill width
* `ctrl-alt-i /`: Fill width as half
* `ctrl-shift-i` or `ctrl-shift-i enter`: Fill height
* `ctrl-shift-i /`: Fill height as half

Override [keymap](https://github.com/minodisk/html-img/blob/master/keymaps/html-img.cson) with `Atom > Open Your Keymap`.

## Configuration

When you specify `src` absolute or protocol-relative url, you can create `project.json` at the project root.

### project.json

* `document_root`: Used for resolving absolute url. Default is `''`.
* `protocol`: Used for resolving protocol-relative url. Default is `'http'`.

### Example

```
.
├──public          # Document root
│   └──index.html  # Files
└──project.json    # Configuration for html-img
```

```json
{
  "document_root": "public",
  "protocol": "https"
}
```

## TODO

* Support [Haml](http://haml.info/) and [Slim](http://slim-lang.com/)
