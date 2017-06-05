var test   = require('tape');
var server = require("../../web.js");
var dir    = __dirname.split('/')[__dirname.split('/').length-1];
var file   = dir + __filename.replace(__dirname, '') + " -> ";

test(file + "GET / Warm Up the Engine", function(t) {
  var options = {
    method: "GET",
    url: "/"
  };
  server.inject(options, function(response) {
    t.equal(response.statusCode, 200, "Welcome to Timer Land Anonymous person!");
    t.end();
  });
});

test(file + "Anonymous people can create timers!", function(t) {
  var options    = {
    method  : "GET",
    url     : "/anonymous"
  };
  server.inject(options, function(res) {
    t.equal(res.statusCode, 200, "Session Created = "+res.result.created);
    var token = res.headers.authorization;
    var timer = {
      "desc" : "Anonymous people deserve a voice too!",
      "start" : new Date().toISOString()
    }
    var options = {
      method: "POST",
      url: "/timer/new",
      payload: timer,
      headers : { authorization : token }
    };
    server.inject(options, function(res) {
      var T = JSON.parse(res.payload);
      t.equal(res.statusCode, 200, "New timer started! " + T.start);
      t.end();
      server.stop();
    });
  });
});
