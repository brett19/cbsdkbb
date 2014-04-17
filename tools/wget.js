﻿var url = require('url'),
    fs = require('fs');

function wget(uri, callback) {
    console.log('Download file from %s', uri);

    var options = url.parse(uri);
    var paths = options.pathname.split('/');
    var filename = paths[paths.length - 1];
    console.log(filename);

    var http = require(uri.indexOf('https') === 0 ? 'https' : 'http');

    var req = http.get(options, function (res) {
        if (res.statusCode !== 200) {
            callback(null);
            return;
        }
        var contentLength = parseInt(res.headers['content-length'], 10);

        var data = new Buffer(contentLength);
        var offset = 0;

        res.on('data', function (buf) {
            buf.copy(data, offset);
            offset += buf.length;
        });

        res.on('end', function () {
            callback(filename, data);
        });
    });

    req.on('error', function (e) {
        console.log('Got error: ' + e.message);
    });
}

module.exports = wget;