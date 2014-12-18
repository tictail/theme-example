gulp = require 'gulp'
util = require 'gulp-util'
coffee = require 'gulp-coffee'
sass = require 'gulp-sass'
tictail = require 'gulp-tictail'
plumber = require 'gulp-plumber'


src =
  scripts: 'src/scripts/*.coffee'
  styles: 'src/styles/*.scss'
dest = 'dist'

errorHandler = (error) ->
  util.log error
  @emit('end')

gulp.task 'styles', ->
  gulp.src(src.styles)
    .pipe(plumber(errorHandler))
    .pipe(sass())
    .pipe(gulp.dest(dest))

gulp.task 'scripts', ->
  gulp.src(src.scripts)
    .pipe(plumber(errorHandler: errorHandler))
    .pipe(coffee())
    .pipe(gulp.dest(dest))

gulp.task 'watch', ->
  gulp.watch(src.styles, ['styles'])
  gulp.watch(src.scripts, ['scripts'])

gulp.task 'serve', -> tictail.serve(store_id: 't')

gulp.task 'upload', -> tictail.upload(token: '<access_token>')

gulp.task 'default', ['watch', 'serve']
