iso8601
=======

[![build status](https://secure.travis-ci.org/calmh/node-iso8601.png)](http://travis-ci.org/calmh/node-iso8601)

    var iso8601 = require('iso8601');
    
    var d = new Date(1325471624000);
    iso8601.fromDate(d); // => 2012-01-02T02:33:44Z
    
    iso8601.toDate('2012-01-02T02:33:44Z'); // => new Date(1325471624000)

License
-------

MIT

