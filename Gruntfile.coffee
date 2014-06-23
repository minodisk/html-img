{ dirname, filename, extname, sep } = require 'path'
firstDirname = (filepath) ->
  filepath.split(sep)[0]
secondDirname = (filepath) ->
  filepath.split(sep)[1]

module.exports = (grunt) ->
  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    esteWatch:
      options:
        dirs: [
          'keymaps/**/*'
          'lib/**/*'
          'menus/**/*'
          'spec/**/*'
          'stylesheets/**/*'
          'node_modules/atom-refactor/**/*'
        ]
        livereload:
          enabled: false
      '*': ->
        [ 'apm:test' ]

  grunt.loadNpmTasks 'grunt-este-watch'

  grunt.registerTask 'apm:test', ->
    done = @async()
    grunt.util.spawn
      cmd: 'apm'
      args: [ 'test' ]
    , (err, result, code) ->
      if err?
        grunt.util.error err
      if result?
        grunt.log.writeln result
      done()

  grunt.registerTask 'default', [
    'apm:test'
    'esteWatch'
  ]
