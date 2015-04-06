var util = require('util'),
    fs = require('fs'),
    path = require('path'),
    wget = require('./wget');

var NPM_PKG_JSON_URL = 'https://raw.githubusercontent.com/joyent/node/v%s/deps/npm/package.json';
var BASE_URL = 'http://nodejs.org/dist/npm/npm-%s.zip';

var targetPath = process.argv[3];
var nodeVersion = process.argv[2];

if (fs.existsSync(targetPath)) {
    console.log('file already exists... skipping');
    process.exit(0);
}

var pkgUri = util.format(NPM_PKG_JSON_URL, nodeVersion);
wget(pkgUri, function (filename, pkg) {
    if (filename === null) {
        console.error('node %s is not include npm', nodeVersion);
        process.exit(1);
    }
    var npmVersion = JSON.parse(pkg).version;
    var uri = util.format(BASE_URL, npmVersion);
    wget(uri, function (filename, data) {
        fs.writeFile(targetPath, data, function (err) {
            if (err) {
                return console.log(err.message);
            }
            console.log('Download npm %s is done', npmVersion);
        });
    });
});
