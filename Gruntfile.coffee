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
          'spec/**/*'
          'stylesheets/**/*'
        ]
        livereload:
          enabled: false
      '*': ->
        [ 'apm:test' ]

  grunt.loadNpmTasks 'grunt-este-watch'

  grunt.registerTask 'apm:test', ->
    start = new Date().getTime()
    done = @async()
    grunt.util.spawn
      cmd: 'apm'
      args: [ 'test' ]
    , (err, result, code) ->
      if err?
        grunt.util.error err
      if result?
        grunt.log.writeln result
      grunt.log.writeln "#{(new Date().getTime() - start) / 1000}sec"
      done()

  grunt.registerTask 'default', [
    'apm:test'
    'esteWatch'
  ]
