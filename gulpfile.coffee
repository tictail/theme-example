gulp = require 'gulp'
util = require 'gulp-util'
coffee = require 'gulp-coffee'
sass = require 'gulp-sass'
tictail = require 'gulp-tictail'


src =
  scripts: 'src/scripts/*.coffee'
  styles: 'src/styles/*.scss'
dest = 'dist'

gulp.task 'styles', ->
  gulp.src(src.styles)
    .pipe(sass().on('error', util.log))
    .pipe(gulp.dest(dest))

gulp.task 'scripts', ->
  gulp.src(src.scripts)
    .pipe(coffee({bare: true}).on('error', util.log))
    .pipe(gulp.dest(dest))

gulp.task 'watch', ->
  gulp.watch(src.styles, ['styles'])
  gulp.watch(src.scripts, ['scripts'])

gulp.task 'serve', -> tictail.serve(id: 'px8')

gulp.task 'upload', -> tictail.upload(token: '<access_token>')

gulp.task 'default', ['watch', 'serve']
