// esbuild.config.js
const esbuild = require("esbuild");

esbuild.build({
   mangleProps: /_$/,
  minify: false,
  entryPoints: ["assets/js/app.js"], // Your entry file
  bundle: true,
  outfile: "priv/static/js/app.js", // Output file
}).catch(() => process.exit(1));