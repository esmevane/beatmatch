module.exports = (grunt) ->
  gruntTasks = require('matchdep').filterDev 'grunt-*'
  grunt.loadNpmTasks task for task in gruntTasks

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    browserify:
      compile:
        files:
          'app/scripts/application.js': ['tmp/src/scripts/application.js']
    cjsx:
      compile:
        expand: true
        cwd: 'assets/scripts'
        src: ['**/*.coffee']
        dest: 'tmp/src/scripts'
        ext: '.js'
    copy:
      sources:
        expand: true
        cwd: 'assets/scripts'
        src: ['**/*.js']
        dest: 'tmp/src/scripts'
    express:
      server:
        options:
          port: 9001
          server: './server'
    mochaTest:
      test:
        options:
          reporter: 'spec'
          require: ['coffee-script', './spec/spec_helper.coffee']
        src: ['spec/**/*.coffee']
    sass:
      compile:
        expand: true
        cwd: 'assets/styles'
        src: ['**/*.sass', '**/*.scss']
        dest: 'app/styles'
        ext: ".css"
        options:
          loadPath: require('node-neat').includePaths
    uglify:
      build:
        files:
          'app/scripts/application.min.js': ['app/scripts/application.js']
    watch:
      express:
        files: ['assets/**/*.coffee', 'assets/**/*.sass']
        tasks: ['build']

  grunt.registerTask 'serve', ['express', 'watch']
  grunt.registerTask 'build', ['cjsx', 'copy', 'sass', 'browserify', 'uglify']
  grunt.registerTask 'test', ['mochaTest']

  grunt.registerTask 'default', ['test', 'build']
