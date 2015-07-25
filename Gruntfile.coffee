
module.exports = (grunt) ->

  loadOptions =
    pattern: 'grunt-*'
    scope: 'devDependencies'

  require('load-grunt-tasks')(grunt, loadOptions)


  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    coffee:
      options:
        bare: true
        sourceMap: true
      alloy:
        files: [
          expand: true
          cwd: 'ti/src/'
          src: [ '**/*.coffee' ]
          dest: 'ti/app/'
          ext: '.js'
        ]
      server:
        files: [
          expand: true
          cwd: 'server'
          src: [ '**/*.coffee' ]
          dest: 'build'
          ext: '.js'
        ]
      test:
        files: [
          expand: true
          cwd: 'ti/tests/'
          src: [ '**/*.coffee' ]
          dest: 'ti/spec/'
          ext: '.js'
        ]

    jade:
      alloy:
        files: [
          expand: true
          cwd: 'ti/src/'
          src: [ '**/*.jade' ]
          dest: 'ti/app/'
          ext: '.xml'
        ]

    ltss:
      alloy:
        files: [
          expand: true
          cwd: 'ti/src/'
          src: [ '**/*.ltss' ]
          dest: 'ti/app/'
          ext: '.tss'
        ]

    copy:
      alloy:
        files: [
          expand: true
          dot: true
          cwd: 'ti/src/'
          dest: 'ti/app/'
          src: [
            '**'
            '!**/*.coffee'
            '!**/*.jade'
            '!**/*.ltss'
          ]
        ]

    tishadow:
      options:
        projectDir: 'ti/'
        update: true
        withAlloy: true
      run:
        command: 'run'
        options:
          alloy:
            platform: [ 'android' ]
      test:
        command: 'spec'
        options:
          alloy:
            platform: [ 'android' ]
      clear:
        command: 'clear'
        options:
          alloy:
            platform: [ 'android' ]

    watch:
      alloy:
        files: [ 'ti/src/**/*' ]
        tasks: [
          'newer:coffee:alloy'
          'newer:jade:alloy'
          'newer:ltss:alloy'
          'newer:copy:alloy'
          # 'tishadow:run'
        ]
        options:
          spawn: false

    clean:
      ti: [
        'ti/Resources/'
        'ti/app/'
        'ti/build/'
        'ti/spec/'
      ]


  grunt.registerTask 'default', [
    'build'
  ]

  grunt.registerTask 'build', [
    'build:ti'
  ]

  grunt.registerTask 'build:ti', [
    'coffee:alloy'
    'jade:alloy'
    'ltss:alloy'
    'copy:alloy'
  ]

  grunt.registerTask 'dev', [
    'build:ti'
    # 'tishadow:run'
    'watch:alloy'
  ]

  grunt.registerTask 'test', [
    'tishadow:clear'
    'clean'
    'build:ti'
    'coffee:test'
    'tishadow:test'
  ]
