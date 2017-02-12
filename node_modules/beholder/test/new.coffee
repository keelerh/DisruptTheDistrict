assert   = require 'assert'
fs       = require 'fs'
path     = require 'path'
beholder = require '../lib/beholder'

pattern = path.join __dirname, 'fixtures/new/**/*'

newFiles = [
  "fixtures/new/base.txt"
  "fixtures/new/sub/sub.txt"
  "fixtures/new/sub/subsub/subsub.txt"
  "fixtures/new/add/add.txt"
  "fixtures/new/sub/add/add.txt"
  "fixtures/new/sub/add/addsub/add.txt"
  "fixtures/new/sub/subsub/add/add.txt"
]

newDirs = [
  "fixtures/new/add"
  "fixtures/new/sub/add"
  "fixtures/new/sub/add/addsub"
  "fixtures/new/sub/subsub/add"
]

remDirs = [
  "fixtures/new/add"
  "fixtures/new/sub/add/addsub"
  "fixtures/new/sub/add"
  "fixtures/new/sub/subsub/add"
]

arrayEqual = (a, b) ->
  a.length is b.length and a.every (elem, i) -> elem in b

describe 'New events', ->

  before ->
    for file, i in newFiles
      newFiles[i] = path.join(__dirname, file)
      try fs.unlinkSync newFiles[i]
    for dir in remDirs
      try fs.rmdirSync path.join(__dirname, dir)

  it 'should emit events on file creation', (done) ->

    beholder pattern, (err, watcher) ->

      assert.ifError err

      found = []

      watcher.on 'new', (fileName) ->
        assert (i for i in found when i is fileName)
        found.push fileName

        if arrayEqual found, newFiles
          watcher.removeAll()
          done()

      for dir in newDirs
        fs.mkdirSync path.join(__dirname, dir)

      createFiles = ->
        for file in newFiles
          fs.writeFileSync file, 'test'

      setTimeout createFiles, 100
        
  after ->
    
    removeFiles = ->
      for file in newFiles
        try fs.unlinkSync file
    
    removeDirs = ->
      for dir in remDirs
        try fs.rmdirSync path.join(__dirname, dir)

    setTimeout removeFiles, 500
    setTimeout removeDirs, 500
