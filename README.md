# html-img package

:sparkles: Fill image size automatically :sparkles:

## Keymap

- `ctrl-i`: Fill width and height

Override keymap with `Atom > Open Your Keymap`.

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
