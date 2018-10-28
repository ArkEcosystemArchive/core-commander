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
    script: `${process.env.CORE_DIR}/packages/core/bin/ark`,
    args: `relay --data ${process.env.CORE_DATA}
                 --config ${process.env.CORE_CONFIG}
                 --token ${process.env.CORE_TOKEN}
                 --network ${process.env.CORE_NETWORK}`,
    max_restarts: 5,
    min_uptime: '5m'
  }, {
    name: 'ark-core-forger',
    script: `${process.env.CORE_DIR}/packages/core/bin/ark`,
    args: `forger --data ${process.env.CORE_DATA}
                  --config ${process.env.CORE_CONFIG}
                  --token ${process.env.CORE_TOKEN}
                  --network ${process.env.CORE_NETWORK}`,
    max_restarts: 5,
    min_uptime: '5m',
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
    env: {
        EXPLORER_HOST: '0.0.0.0',
        EXPLORER_PORT: 4200
    }
  }]
};
