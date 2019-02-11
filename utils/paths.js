const envPaths = require('env-paths');
const expandHomeDir = require('expand-home-dir');
const { resolve } =  require('path');

if (process.argv.length !== 4) {
    throw new Error("Expected 1 argument for the token and network name");
}

const token = process.argv[2];
const network = process.argv[3];

let corePaths = envPaths(token, { suffix: "core" });

["data", "config", "cache", "log", "temp"].forEach(key => {
    if (corePaths[key]) {
        const name = `CORE_PATH_${key.toUpperCase()}`;

        const path = resolve(expandHomeDir(corePaths[key]));

        corePaths[key] = `${path}/${network}`;
    }
});

console.log(JSON.stringify(corePaths))
