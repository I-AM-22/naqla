// eslint-disable-next-line no-undef
module.exports = {
  /** @type {import('orval').Options} */
  api: {
    input: `https://naqla.onrender.com/api.json`,
    output: {
      mode: "split",
      target: "./service/api.ts",
      override: {
        mutator: {
          path: "./lib/fetch.ts",
          name: "fetchInstance",
        },
        useNamedParameters: true,
        useDates: true,
        useTypeOverInterfaces: true,
        mock: true,
      },
    },
    hooks: {
      afterAllFilesWrite: "prettier --write",
    },
  },
};
