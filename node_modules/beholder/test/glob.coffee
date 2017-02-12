assert   = require 'assert'
fs       = require 'fs'
path     = require 'path'
beholder = require '../lib/beholder'

pattern = path.join __dirname, 'fixtures/any/**/*'

files = [ 
  'fixtures/any/base.txt',
  'fixtures/any/sub/sub.txt',
  'fixtures/any/sub/subsub/subsub.txt' 
]

dirs = [
  'fixtures/any',
  'fixtures/any/sub',
  'fixtures/any/sub/subsub' 
]

arrayEqual = (a, b) ->
  a.length is b.length and a.every (elem, i) -> path.normalize(elem) in b

describe 'Glob', ->

  before ->
    for file, i in files
      files[i] = path.join(__dirname, file)
    for dir, i in dirs
      dirs[i] = path.join(__dirname, dir)

  it 'should add directories to the watch list', (done) ->

    beholder pattern, (err, watcher) ->
      assert.ifError err
      assert arrayEqual(watcher.listDir(), dirs)
      watcher.removeAll()
      done()

  it 'should add files to the watch list', (done) ->

    beholder pattern, (err, watcher) ->
      assert.ifError err
      assert arrayEqual(watcher.list(), files)
      watcher.removeAll()
      done()

  it 'should add a single file to the watch list', (done) ->

    beholder path.join(__dirname, 'fixtures/any/base.txt'), (err, watcher) ->
      assert.ifError err
      assert.equal watcher.list().length, 1
      assert arrayEqual watcher.list(), [path.join(__dirname, 'fixtures/any/base.txt')]
      watcher.removeAll()
      done()

  it 'should add a single directory to the watch list', (done) ->

    beholder path.join(__dirname, 'fixtures/any/*'), (err, watcher) ->
      assert.ifError err
      assert.equal watcher.list().length, 1
      assert.equal watcher.listDir().length, 2
      assert arrayEqual watcher.list(), [path.join(__dirname, 'fixtures/any/base.txt')]
      watcher.removeAll()
      done()