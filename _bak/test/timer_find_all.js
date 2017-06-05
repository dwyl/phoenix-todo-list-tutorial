var test   = require('tape');
var server = require("../../web.js");
var dir    = __dirname.split('/')[__dirname.split('/').length-1];
var file   = dir + __filename.replace(__dirname, '') + " -> ";
var token;
var records = 10;
var countdown = records;

var helpers = require('./_test_helpers');
test(file+ "Teardown", function(t) {
  helpers.drop(function(res){
    t.equal(res.acknowledged, true, file+"ALL Records DELETED!");
    t.end();
  }).end();
});

test(file + "Register new person to create a few timers", function(t) {
  var email  = 'dwyl.test+multiple_timers' +Math.random()+'@gmail.com';
  var person = {
    "email"    : email,
    "password" : "EveryThingisAwesome",
    "firstname": "Jenny"
  }
  var options = {
    method  : "POST",
    url     : "/register",
    payload : person
  };
  server.inject(options, function(res) {
    // console.log(res.result);
    t.equal(res.statusCode, 200, "Session Created = "+res.result.created);
    token = res.headers.authorization;
    helpers.create_many(records, t, token, helpers.finish);
  });
});

test(file + "GET /timer/all to list all timers", function(t) {
  var options = {
    method: "GET",
    url: "/timer/all",
    headers : { authorization : token }
  };
  setTimeout(function(){
    server.inject(options, function(res) {
      // console.log(res.result);
      var T = JSON.parse(res.payload);
      // console.log(T);
      t.equal(res.statusCode, 200, "Find all records for this person");
      t.true(T.timers.length > 1, "TRAVIS (Free/Slow) ElasticSearch (ONLY) Found: "+T.timers.length);
      server.stop();
      t.end();
    });
  },1000)
});

test(file + "GET /timer/all should fail for Timmy no timers", function(t) {
  var person = {
    "email"    : "dwyl.test+timmy_no_timers@gmail.com",
    "password" : "EveryThingisAwesome"
  }
  var options = {
    method  : "POST",
    url     : "/register",
    payload : person
  };
  server.inject(options, function(res) {
    var newtoken = res.headers.authorization;
    var options = {
      method: "GET",
      url: "/timer/all",
      headers : { authorization : newtoken }
    };
    setTimeout(function(){
      server.inject(options, function(res) {
        // console.log(res.result);
        var T = JSON.parse(res.payload);
        t.equal(res.statusCode, 404, "Timmay! has no timers...");
        // t.equal(T.hits.total, 100, "100 records found");
        server.stop();
        t.end();
      });
    },200)
  });
});
