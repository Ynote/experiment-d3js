# modules
gulp      = require 'gulp'
plumber   = require 'gulp-plumber'
uglify    = require 'gulp-uglify'
minifycss = require 'gulp-minify-css'

# conf
jsPath = 'js/*.js'
cssPath = 'css/*.css'

# tasks
gulp.task 'js', ->
    gulp.src jsPath
        .pipe(plumber())
        .pipe(uglify())
        .pipe(plumber.stop())
        .pipe(gulp.dest 'js/gen')

gulp.task 'css', ->
    gulp.src cssPath
        .pipe(plumber())
        .pipe(minifycss())
        .pipe(plumber.stop())
        .pipe(gulp.dest 'css/gen')

gulp.task 'default', ->
    gulp.watch jsPath, ['js']
    gulp.watch cssPath, ['css']
