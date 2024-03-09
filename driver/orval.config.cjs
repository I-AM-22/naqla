const env = "development";
let str = "";
if (env === "development") {
  str = ".dev";
} else if (env === "testing") {
  str = ".test";
}

// eslint-disable-next-line no-undef
module.exports = {
  /** @type {import('orval').Options} */
  api: {
    input: `http://localhost:5500/api.json`,
    output: {
      mode: "split",
      target: "./swagger/api.ts",
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
