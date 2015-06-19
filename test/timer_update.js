var test   = require('tape');
var server = require("../../web.js");
var dir    = __dirname.split('/')[__dirname.split('/').length-1];
var file   = dir + __filename.replace(__dirname, '') + " -> ";
var timer;
var token;

test(file + "CREATE a NEW Timer without a desc (which we will update below)", function(t) {
  var options = { method : "GET", url : "/anonymous" };
  server.inject(options, function(res) {
    token = res.headers.authorization;
    // blank timer
    var options = {
      method: "POST",
      url: "/timer/new",
      headers : { authorization : token }
    };
    server.inject(options, function(response) {
      // console.log(response.result);
      t.equal(response.statusCode, 200, "New Timer Created: "+response.result.start);
      timer = response.result;
      t.end();
      server.stop();
    });
  });
});

test(file + "POST /timer/upsert to set a description", function(t) {
  var updated = {
    id: timer.id,

    desc: "updated now"
  }
  var options = {
    method: "POST",
    url: "/timer/upsert",
    payload: updated,
    headers : { authorization : token }
  };
  server.inject(options, function(response) {
    // console.log(response.result);
    t.equal(response.statusCode, 200, "Timer description updated to: "
      + response.result.desc +'\n');
    t.equal(response.result.desc, updated.desc, "Timer description updated successfully");
    t.end();
    server.stop();
  });
});

test(file + "POST /timer/upsert with a NEW TIMER but NO start (fault tolerance)", function(t) {
  var options = {
    method: "POST",
    url: "/timer/upsert",
    payload: {id:"1234"},
    headers : { authorization : token }
  };
  server.inject(options, function(response) {
    // console.log(response.result);
    t.equal(response.statusCode, 200, "New Timer Created: "+response.result.start);
    timer = response.result;
    t.end();
    server.stop();
  });
});

test(file + "POST /timer/upsert with a NEW TIMER with start (fault tolerance)", function(t) {
  var options = {
    method: "POST",
    url: "/timer/upsert",
    payload: {id:"1234", start: new Date().toISOString() },
    headers : { authorization : token }
  };
  server.inject(options, function(response) {
    // console.log(response.result);
    t.equal(response.statusCode, 200, "New Timer Created: "+response.result.start);
    timer = response.result;
    t.end();
    server.stop();
  });
});
