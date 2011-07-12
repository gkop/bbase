BBase.loadedScripts = [];

BBase.maybeLoad = function(callback, jsFiles) {
  var n = arguments.length
  var buf = "LazyLoad.js([";
  for (i=1; i < n; i++) {
    if (BBase.loadedScripts[arguments[i]] == undefined) {
      BBase.loadedScripts[arguments[i]] = true;
      buf += "'"+arguments[i]+"'"
      if (i < n-1) {
        buf += ","
      }
    }
  }
  buf += "]";
  if (arguments[0] != "null") {
    buf += ", "+arguments[0]
  }
  buf += ");";
  eval(buf);
};
