###
Grammar definition for html, ejs and eco.
###


{ Point, Range } = require 'atom'
Node = require './helper/Node'
EJS = require './ejs'


module.exports =
class PHP extends EJS

  @fileTypes: [
    'php'
  ]

  @rCode: /<\?.*?\?>/g
