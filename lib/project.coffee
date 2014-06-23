{ readFileSync, statSync } = require 'fs'
{ parseFileSync } = require 'cson'

hasFile = (filename) ->
  statSync(atom.project.resolve filename).isFile()

console.log atom.project.resolve 'project.cson'

# if hasFile 'project.cson'
#   console.log parseFileSync fileCson
# else if hasFile 'project.json'
#   console.log JSON.parse readFileSync fileCson
