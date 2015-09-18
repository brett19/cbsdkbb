var url = require('url'),
    bytes = require('./bytes'),
    fs = require('fs');

function wget(uri, callback) {
    console.log('Download file from %s', uri);

    var options = url.parse(uri);
    var paths = options.pathname.split('/');
    var filename = paths[paths.length - 1];
    console.log(filename);

    var http = require(uri.indexOf('https') === 0 ? 'https' : 'http');

    var req = http.get(options, function (res) {
        if (res.statusCode === 302 || res.statusCode === 301) {
            console.log('Redirect: ' + res.headers.location);
            return wget(res.headers.location, callback);
        }
        if (res.statusCode !== 200) {
            callback(null);
            return;
        }
        var contentLength = parseInt(res.headers['content-length'], 10);
        console.log('Content length is %s', bytes(contentLength));

        var data = new Buffer(0);
        var offset = 0;

        var lastLog = Date.now();
        console.log(''); // New line for ESC_UP_CLL
        res.on('data', function (buf) {
            data = Buffer.concat([data, buf]);

            if (Date.now() - lastLog > 500) {
                console.log('Download %d%, %s / %s, %s/s ...',
                    parseInt(data.length / contentLength * 100, 10), bytes(data.length), bytes(contentLength),
                    bytes(data.length / use * 1000));
                lastLog = Date.now();
            }
        });

        res.on('end', function () {
            console.log('Download done');
            callback(filename, data);
        });
    });

    req.on('error', function (e) {
        console.log('Got error: ' + e.message);
    });
}

module.exports = wget;
