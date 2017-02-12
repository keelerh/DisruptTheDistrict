assert   = require 'assert'
fs       = require 'fs'
path     = require 'path'
beholder = require '../lib/beholder'

pattern = path.join __dirname, 'fixtures/remove/**/*'

newFiles = [
  "fixtures/remove/base.txt"
  "fixtures/remove/sub/sub.txt"
  "fixtures/remove/sub/subsub/subsub.txt"
]

arrayEqual = (a, b) ->
  a.length is b.length and a.every (elem, i) -> path.normalize(elem) in b

describe 'Remove events', ->

  before ->
    for file, i in newFiles
      newFiles[i] = path.join(__dirname, file)
      try fs.writeFileSync newFiles[i], 'test'

  it 'should emit events on file deletion', (done) ->

    beholder pattern, (err, watcher) ->

      assert.ifError err

      found = []

      watcher.on 'remove', (fileName) ->
        assert (i for i in found when i is fileName)
        found.push fileName

        if arrayEqual found, newFiles
          watcher.removeAll()
          done()

      removeFiles = ->
        for file in newFiles
          fs.unlinkSync file, 'test'

      setTimeout removeFiles, 100
        
  after ->
    for file in newFiles
      try fs.unlinkSync file
