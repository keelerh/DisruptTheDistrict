assert   = require 'assert'
fs       = require 'fs'
path     = require 'path'
beholder = require '../lib/beholder'

pattern = path.join __dirname, 'fixtures/change/**/*'

arrayEqual = (a, b) ->
  a.length is b.length and a.every (elem, i) -> elem in b

describe 'Change events', ->

  it 'should emit events on file modification', (done) ->

    beholder pattern, (err, watcher) ->

      assert.ifError err

      found = []
      files = watcher.list()

      watcher.on 'change', (fileName) ->
        assert (i for i in found when i is fileName)
        found.push fileName

        if arrayEqual found, files
          watcher.removeAll()
          done()

      for file in files
        fs.writeFileSync file, 'test'