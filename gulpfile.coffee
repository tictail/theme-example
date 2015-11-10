gulp = require 'gulp'
util = require 'gulp-util'
coffee = require 'gulp-coffee'
sass = require 'gulp-sass'
tictail = require 'gulp-tictail'
plumber = require 'gulp-plumber'
livereload = require 'gulp-livereload'


src =
  scripts: 'src/scripts/*.coffee'
  styles: 'src/styles/*.scss'
  theme: 'src/*.mustache'
dest = 'dist'

errorHandler = (error) ->
  util.log error
  @emit 'end'

gulp.task 'styles', ->
  gulp.src src.styles
    .pipe plumber errorHandler
    .pipe sass()
    .pipe gulp.dest dest
    .pipe livereload()

gulp.task 'scripts', ->
  gulp.src src.scripts
    .pipe plumber errorHandler: errorHandler
    .pipe coffee()
    .pipe gulp.dest dest
    .pipe livereload()

gulp.task 'theme', ->
  gulp.src src.theme
    .pipe livereload()

gulp.task 'watch', ->
  gulp.watch src.styles, ['styles']
  gulp.watch src.scripts, ['scripts']
  gulp.watch src.theme, ['theme']

gulp.task 'serve', ->
  tictail.serve store_id: 't'
  livereload.listen basePath: dest

gulp.task 'default', ['watch', 'serve']
