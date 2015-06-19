var test   = require('tape');
var server = require("../../web.js");
var dir    = __dirname.split('/')[__dirname.split('/').length-1];
var file   = dir + __filename.replace(__dirname, '') + " -> ";

test(file + "GET timer /timer/1 (invalid timer id) should return 404", function(t) {
  var options = { method : "GET", url : "/anonymous" };
  server.inject(options, function(res) {
    var token = res.headers.authorization;
    var options = {
      method: "GET",
      url: "/timer/1",
      headers : { authorization : token }
    };
    server.inject(options, function(response) {
      t.equal(response.statusCode, 404, "Record did not exist, as expected");
      t.end();
      server.stop();
    });
  });
});
