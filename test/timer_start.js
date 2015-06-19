var test   = require('tape');
var server = require("../../web.js");
var dir    = __dirname.split('/')[__dirname.split('/').length-1];
var file   = dir + __filename.replace(__dirname, '') + " -> ";
var token;

test(file + "POST /timer/new should FAIL when no Auth Token Sent", function(t) {
  var options = { method : "GET", url : "/anonymous" };
  server.inject(options, function(res) {
    token = res.headers.authorization;
    var options = {
      method: "POST",
      url: "/timer/new",
      payload: {
        "ct" : "fail", // we don't allow people/apps to set the created time!
        "desc" : "its time!"
      }
    };
    server.inject(options, function(response) {
      t.equal(response.statusCode, 401, "New timer FAILS JTW Auth: "
        + response.result.message+'\n');
      t.end();
      server.stop();
    });
  });
});

test(file + "POST /timer/new should FAIL when supplied VALID token but bad payload", function(t) {
  var options = {
    method: "POST",
    url: "/timer/new",
    payload: {
      "ct" : "fail", // we don't allow people/apps to set the created time!
      "desc" : "its time!"
    },
    headers : { authorization : token }
  };
  server.inject(options, function(response) {
    t.equal(response.statusCode, 400, "New timer FAILS validation: "
      + response.result.message +'\n');
    t.end();
    server.stop();
  });
});

test(file + "START a NEW Timer (no st sent by client)!", function(t) {
  var timer = { "desc" : "Get the Party Started!" }
  var options = {
    method: "POST",
    url: "/timer/new",
    payload: timer,
    headers : { authorization : token }
  };
  server.inject(options, function(res) {
    var T = JSON.parse(res.payload);
    t.equal(res.statusCode, 200, "New timer started! " + T.start);
    var tid = T.id;
    var options = {
      method: "GET",
      url: "/timer/"+tid,
      payload: timer,
      headers : { authorization : token }
    };
    server.inject(options, function(res) {
      t.equal(res.statusCode, 200, "New timer retrieved!"+'\n');
      t.end();
      server.stop();
    });
  });
});

test(file + "START a NEW Timer with start time!", function(t) {
  var timer = {
    "desc" : "We're going to Ibiza!",
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
    t.equal(res.statusCode, 200, "New timer started! " + T.start+'\n');
    t.end();
    server.stop();
  });
});
