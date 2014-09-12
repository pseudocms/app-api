var ReactTools = require("react-tools");
var Coffee = require("coffee-script");

function compile(src, path) {
  if (path.match(/\.coffee$/)) {
    return Coffee.compile(src, { "bare": true });
  }

  return src;
}

module.exports = {
  process: function(src, path) {
    return ReactTools.transform(compile(src, path));
  }
};
