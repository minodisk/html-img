# html-img package

:sparkles: Fill image size automatically :sparkles:

![capture](https://cloud.githubusercontent.com/assets/514164/3368247/cbc085a0-fb71-11e3-9e67-4288427a3861.gif)

## Keymap

- `ctrl-i`, `ctrl-i i`: Fill width and height
- `ctrl-i w`: Fill width
- `ctrl-i h`: Fill height

Override [keymap](https://github.com/minodisk/html-img/blob/master/keymaps/html-img.cson) with `Atom > Open Your Keymap`.

## Supported grammar

- HTML
- [Jade](http://jade-lang.com/)

## Supported url type

- Absolute url: Like `/images/sample.png` (requires project.json 'root' property)
- Relative url: Like `images/smaple.png`
- Protocol-absolute url: Like `http://example.com/images/sample.png`
- Protocol-relative url: Like `//example.com/images/sample.png` (requires project.json 'protocol' property)

## Supported image type

- PNG
- JPG
- GIF

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
