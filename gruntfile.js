var path = require("path"),
  fs = require("fs"),
  mxClientContent,
  deps;

const mxGraphConfigs = [
  "mxBasePath",
  "mxLoadStylesheets",
  "mxResourceExtension",
  "mxForceIncludes",
  "mxImageBasePath",
  "mxLoadResources",
  "mxDefaultLanguage",
  "mxLanguages",
  "urlParams",
  "DOM_PURIFY_CONFIG",
  "STENCIL_PATH",
  "uiTheme",
  "mxLanguage",
];

const mxObjects = [
  "WeightedCellSorter", // layout/mxGraphLayout.js
  "MedianCellSorter", // mxMedianHybridCrossingReduction.js
  "mxSelectionChange", // mxGraphSelectionModel.js
  "mxCurrentRootChange", // mxGraphView.js
  "mxRootChange",
  "mxChildChange",
  "mxTerminalChange",
  "mxValueChange",
  "mxStyleChange",
  "mxGeometryChange",
  "mxCollapseChange",
  "mxVisibleChange",
  "mxCellAttributeChange",
];

const externalJsPre = ["./mxClient.js"];

const externalJsSuf = [
  "./ge/Editor.js",
  "./ge/Actions.js",
  "./ge/EditorUi.js",
  "./ge/Menus.js",
  "./ge/Sidebar.js",
  "./ge/Graph.js",
  "./ge/Shapes.js",
  "./shapes/mxBpmnShape2.js",

  // 修改和增强mxGraph
  "./adapter/Graph.js",
];

module.exports = function (grunt) {
  // To get the dependencies for the project, read the filenames by matching
  // mxClient.include([...]) in mxClient.js. This is not perfect, but the list is
  // required in mxClient.js for compatibility.
  mxClientContent = fs.readFileSync(
    path.join(process.cwd(), "./src/js/mxClient.js"),
    "utf8"
  );
  deps = mxClientContent
    .match(/mxClient\.include\([^"']+["'](.*?)["']/gi)
    .map(function (str) {
      return "." + str.match(/mxClient\.include\([^"']+["'](.*?)["']/)[1];
    });
  deps = externalJsPre.concat(deps.slice(0)).concat(externalJsSuf);
  grunt.initConfig({
    copy: {
      main: {
        files: [
          {
            expand: true,
            cwd: "./src/js",
            src: deps,
            dest: "./build",
          },
        ],
        options: {
          // After each module, add the object to the '__mxOutput' namespace
          // E.g. __mxOutput.mxLog, etc.
          process: function (content, srcpath) {
            var afterContent = "",
              moduleName = path.basename(srcpath, ".js");

            afterContent +=
              "\n__mxOutput." +
              path.basename(srcpath, ".js") +
              " = typeof " +
              moduleName +
              " !== 'undefined' ? " +
              moduleName +
              " : undefined;\n";

            return content + afterContent;
          },
        },
      },
    },
    concat: {
      dist: {
        src: deps.map(function (dep) {
          return path.join("./build", dep);
        }),
        dest: "./dist/mgraph.js",
      },
      options: {
        banner: `// @ts-ignore
        /* eslint-disable */
        import pako from 'pako'
        import DOMPurify from 'dompurify';
        import mxConfigs from './config'
        let {${mxGraphConfigs.join(", ")}} = mxConfigs
        const factory = function (opts) {
          var __mxOutput = {};
        `,
        footer: `  
          ${mxObjects.map((v) => `__mxOutput.${v} = ${v}`).join(";\n")}
          return __mxOutput;
        };
        export default factory;`,
      },
    },
    uglify: {
      build: {
        src: "./dist/mgraph.js",
        dest: "./dist/mgraph.min.js",
      },
    },
    clean: {
      build: ['./build']
    }
  });

  require("load-grunt-tasks")(grunt);
  grunt.registerTask("default", ["copy", "concat", "uglify", "clean"]);
  grunt.registerTask("build", ["default"]);
};
