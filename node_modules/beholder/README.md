# Beholder

Beholder is a cross-platform file watcher for Node.js.

## Features

* Watch full directory trees for changes
* Globbing syntax for fine-grained control
* Detects new files and directories automatically 
* Handles large file sets
* Event-based API
* Cross-platform

## Installation

Install via npm:

    $ npm install beholder

## Usage

    var beholder = require('beholder')

    var watcher = beholder('**/*')

    watcher.on('ready', function() {
      console.log("Beholder ready and watching these files: ")
      console.dir(watcher.list())
    })

    watcher.on('any', function(file, event) {
      console.log('%s had event %s', file, event)
    })

    watcher.on('change', function(file) {
      console.log('%s has been modified', file)
    })

    watcher.on('new', function(file) {
      console.log('%s has been created', file)
    })

    watcher.on('remove', function(file) {
      console.log('%s has been removed', file)
    })

    watcher.on('error', function(err) {
      console.log(err)
    })

## API

#### beholder(pattern, [options], [cb])

Create a new beholder to watch files and directories matching the specified pattern. Specify a
callback that will be invoked after the initial set of files have begun to be watched,
or listen for the 'ready' event.

See the [minimatch documentation](https://github.com/isaacs/minimatch) for details on valid file patterns.

###### Options:

* `interval` - The interval for file polling. Only used for large file sets, defaults to 5007.
* `persistent` - Continue to run as long as files are being watched. Defaults to true.
* `includeHidden` - Include hidden dotfiles on the watch list. Defaults to false.
* `exclude` - An array of patterns to exclude from the watch list.

###### Events:

* `any` - Emitted whenever a watched file has been modifed, added or removed.
* `change` - Emitted whenever a watched file has beed mofified.
* `new` - Emitted whenever a file is added to the watch list.
* `remove` - Emitted when a file is deleted.
* `error` - Emitted whenever an unhandled error is generated.
* `ready` - Emitted after all initial files have begun to be watched.

###### Methods:

* __list()__ - Lists all files currently being watched.
* __listDir()__ - Lists all directories currently being watched.
* __add(pattern, silent)__ - Add `pattern` to the watch list. Specify `silent` to suppress events.
* __remove(filePath, silent)__ - Remove `filePath` from the watch list. Specify `silent` to suppress events.
* __removeAll(silent)__ - Remove all watched files and directories from the watch list.Specify `silent` to suppress events.

## Large file sets

Beholder uses fs.watch() by default, but will fallback to stat polling automatically to handle
large file sets. Use the `interval` option noted above for fine-grained control over the
polling time when needed.

## Running the tests

To run the test suite, invoke the following commands in the repository:

    $ npm install
    $ npm test

## License

(The MIT License)

Copyright (c) 2013 Charles Moncrief <<cmoncrief@gmail.com>>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.