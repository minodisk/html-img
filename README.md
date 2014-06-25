# html-img package

Fill image size automatically.

![capture](https://cloud.githubusercontent.com/assets/514164/3368247/cbc085a0-fb71-11e3-9e67-4288427a3861.gif)

* Supports HTML, [Jade](http://jade-lang.com/)<!--, [EJS](http://embeddedjs.com/) -->
* Supports png, jpg and gif
* Overwrites wrong size
* You can choose filling only width, height or both
* You can choose filling with full or half size
* Supports absolute url: Like `/images/sample.png` (requires `document_root` property in [project.json](#projectjson))
* Supports relative url: Like `images/smaple.png`
* Supports protocol-absolute url: Like `http://example.com/images/sample.png`
* Supports protocol-relative url: Like `//example.com/images/sample.png` (requires `protocol` property in [project.json](#projectjson))

## Keymap

- `ctrl-i` or `ctrl-i enter`: Fill width and height
- `ctrl-i /`: Fill width and height as half
- `ctrl-alt-i` or `ctrl-alt-i enter`: Fill width
- `ctrl-alt-i /`: Fill width as half
- `ctrl-shift-i` or `ctrl-shift-i enter`: Fill height
- `ctrl-shift-i /`: Fill height as half

Override [keymap](https://github.com/minodisk/html-img/blob/master/keymaps/html-img.cson) with `Atom > Open Your Keymap`.

## Configuration

When you specify `src` absolute or protocol-relative url, you can create `project.json` at the project root.

### project.json

- `document_root`: Used for resolving absolute url. Default is `''`.
- `protocol`: Used for resolving protocol-relative url. Default is `'http'`.

### Example

```
.
├──htdocs          # Document root
│   └──index.jade  # HTML/Jade files here
└──project.json    # Configuration for html-img
```

```json
{
  "document_root": "htdocs",
  "protocol": "https"
}
```
