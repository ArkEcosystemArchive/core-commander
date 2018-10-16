require('dotenv').config({ path: `${process.env.HOME}/.commander` })

const parseArg = (key) => {
    const index = process.argv.indexOf(key)
    if (index !== -1) {
        return `${key} ${process.argv[index + 1]}`
    }

    return ''
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
                  --network ${process.env.CORE_NETWORK}
                  ${parseArg('--bip38')}
                  ${parseArg('--password')}`,
    max_restarts: 5,
    min_uptime: '5m'
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
