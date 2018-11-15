var fs = require("fs");
var peg = require("pegjs");

var parser_source = fs.readFileSync(__dirname + "/parser.pegjs", "utf8");
var parser = peg.generate(parser_source);

module.exports.parse = parser.parse;
