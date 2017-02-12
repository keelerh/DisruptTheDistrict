/*jslint onevar: true, node: true, continue: false, plusplus: false, bitwise: true,
newcap: true, strict: false, maxerr: 50, indent: 4, undef: true */

/*globals exports: true */

exports.toDate = toDate;
exports.fromDate = fromDate;

// Legacy compatibility
exports.toIso8601 = fromDate;
exports.fromIso8601 = toDate;

function padInteger(num, length) {
    var r = "" + num;
    while (r.length < length) {
        r = "0" + r;
    }
    return r;
}

function toDate(string) {
    var regexp, d, offset, date, time;

    regexp = "([0-9]{4})(-([0-9]{2})(-([0-9]{2})" +
        "(T([0-9]{2}):([0-9]{2})(:([0-9]{2})(\\.([0-9]+))?)?" +
        "(Z|(([-+])([0-9]{2}):([0-9]{2})))?)?)?)?";
    d = string.match(new RegExp(regexp));

    offset = 0;
    date = new Date(d[1], 0, 1);

    if (d[3]) {
        date.setMonth(d[3] - 1);
    }
    if (d[5]) {
        date.setDate(d[5]);
    }
    if (d[7]) {
        date.setHours(d[7]);
    }
    if (d[8]) {
        date.setMinutes(d[8]);
    }
    if (d[10]) {
        date.setSeconds(d[10]);
    }
    if (d[12]) {
        date.setMilliseconds(("0." + d[12]) * 1000);
    }
    if (d[14]) {
        offset = (d[16] * 60) + d[17];
        offset *= ((d[15] === '-') ? 1 : -1);
    }

    offset -= date.getTimezoneOffset();
    time = date.getTime() + offset * 60 * 1000;
    return new Date(time);
};

function fromDate(d) {
    var year, month, day, hour, minute, second;
    year = d.getUTCFullYear();
    month = padInteger(d.getUTCMonth() + 1, 2);
    day = padInteger(d.getUTCDate(), 2);
    hour = padInteger(d.getUTCHours(), 2);
    minute = padInteger(d.getUTCMinutes(), 2);
    second = padInteger(d.getUTCSeconds(), 2);
    return year + '-' + month + '-' + day + 'T' + hour + ':' + minute + ':' + second + 'Z';
};

