assert   = require 'assert'
fs       = require 'fs'
path     = require 'path'
beholder = require '../lib/beholder'

pattern    = path.join __dirname, 'fixtures/any/**/*'
addPattern = path.join __dirname, 'fixtures/change/**/*'

describe 'Add', ->

  it 'should add files matching new patterns', (done) ->

    beholder pattern, (err, watcher) ->

      assert.ifError err
      numFiles = watcher.list().length

      watcher.add addPattern, (err, addWatcher) ->
        assert addWatcher.list().length is (numFiles * 2)
        done()

describe 'Remove', ->

  it 'should stop watching files', (done) ->

    beholder pattern, (err, watcher) ->

      assert.ifError err
      assert numFiles = watcher.list().length

      watcher.remove watcher.list()[0]
      assert watcher.list().length is (numFiles - 1)
      done()

  it 'should stop watching all files', (done) ->

    beholder pattern, (err, watcher) ->

      assert.ifError err
      assert numFiles = watcher.list().length

      watcher.removeAll()
      assert.equal watcher.list().length, 0

      done()
