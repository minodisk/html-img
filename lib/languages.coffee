{ readdirSync, statSync } = require 'fs'
{ resolve, basename, extname } = require 'path'
{ inspect } = require 'util'

dir = resolve __dirname, 'languages'
for file in readdirSync dir
  stats = statSync resolve dir, file
  continue unless stats.isFile()
  name = basename file, extname file
  cls = require "./languages/#{name}"
  continue unless cls.find? and cls.replace?
  exports[name] = cls
