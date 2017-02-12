var should = require('should');

var iso8601 = require('../lib/iso8601');

describe('The ISO8601 library', function () {
    // jb@zdev:~ % date +%s -d "2012-01-02 02:33:44 UTC"
    // 1325471624
 
    it('produces a correct ISO8601 string for a given Date', function () {
        var d = new Date(1325471624000);
        iso8601.fromDate(d).should.equal('2012-01-02T02:33:44Z');
    });

    it('parses an ISO8601 string and returns the correct Date', function () {
        var d = new Date(1325471624000);
        iso8601.toDate('2012-01-02T02:33:44Z').should.equal(d);
    });
});

