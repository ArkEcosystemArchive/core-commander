require('dotenv').config({ path: `${process.env.HOME}/.commander` })

const delegates = require(`${process.env.CORE_CONFIG}/delegates.json`)

const getPasswordFromArgs = () => {
    const index = process.argv.indexOf('--password')
    if (index !== -1) {
        return process.argv[index + 1]
    }

    return undefined
}

module.exports = {
  apps : [{
    name: 'ark-core-relay',
    script: `${process.env.CORE_DIR}/packages/core/dist/index.js`,
    args: `relay --data ${process.env.CORE_DATA}
                 --config ${process.env.CORE_CONFIG}`,
    max_restarts: 5,
    min_uptime: '5m',
    kill_timeout: 30000
  }, {
    name: 'ark-core-forger',
    script: `${process.env.CORE_DIR}/packages/core/dist/index.js`,
    args: `forger --data ${process.env.CORE_DATA}
                  --config ${process.env.CORE_CONFIG}`,
    max_restarts: 5,
    min_uptime: '5m',
    kill_timeout: 30000,
    env: {
        ARK_FORGER_BIP38: delegates.bip38,
        ARK_FORGER_PASSWORD: getPasswordFromArgs()
    }
  }, {
    name: 'ark-explorer',
    script: `${process.env.EXPLORER_DIR}/express-server.js`,
    args: `--name ark-explorer`,
    max_restarts: 5,
    min_uptime: '5m',
    kill_timeout: 30000,
    env: {
        EXPLORER_HOST: '0.0.0.0',
        EXPLORER_PORT: 4200
    }
  }]
};
