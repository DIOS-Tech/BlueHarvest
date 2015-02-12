module.exports = function(grunt) {

  require('load-grunt-tasks')(grunt);

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    jshint: {
      files: ['Gruntfile.js', 'build/bluey.js'],
      options: {
        node: true,
        globals: {
          jQuery: true,
          React: true,
          alert: true,
          document: true
        }
      }
    },
    '6to5': {
      options: {
        sourceMap: true
      },
      dist: {
        files: {
          'build/bluey.js': 'src/bluey.es6.js'
        }
      }
    },
    uglify: {
      options: {
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      },
      build: {
        src: 'build/<%= pkg.name %>.js',
        dest: 'build/<%= pkg.name %>.min.js'
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-uglify');

  grunt.registerTask('default', ['6to5', 'jshint', 'uglify']);
};
