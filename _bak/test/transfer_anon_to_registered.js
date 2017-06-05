var test   = require('tape');
var JWT    = require('jsonwebtoken');
var server = require("../../web.js");
var dir    = __dirname.split('/')[__dirname.split('/').length-1];
var file   = dir + __filename.replace(__dirname, '') + " -> ";
var email  = "dwyl.test+transfer_"+Math.random()+"@gmail.com"
var helpers = require('./_test_helpers');

var person = {
  "email"    : email,
  "password" : "SoCloseTo10kh!"
}

var token;
var tid;

test(file + "Anonymous person can creates a timer, then register", function(t) {
  var options    = {
    method  : "GET",
    url     : "/anonymous"
  };
  server.inject(options, function(res) {
    t.equal(res.statusCode, 200, "Session Created = "+res.result.created);
    token = res.headers.authorization;
var decoded = JWT.verify(token, process.env.JWT_SECRET);
// console.log(" - - - - - - - - - - - - - - - - - - - decoded: ")
// console.log(decoded);
// console.log(" - - - - - - - - - - - - - - - - - - - ")
    helpers.create_many(5, t, token, function(res) {
      // console.log(res.result);
      tid = res.result.id;
      t.end();
    });
  });
});

test(file + "Transfer records created by anon to registered person", function(t){
  var options = {
    method  : "POST",
    url     : "/register",
    headers : { authorization : token },
    payload : person
  };
  setTimeout(function(){
    server.inject(options, function(res) {
      t.equal(res.statusCode, 200, "Person registration is succesful");
      t.end();
    });
  },1000);
})

var aguid = require('aguid');

test(file + "Lookup the timer confirm the person is set", function(t){
  var personid = aguid(email);
  var options = {
    method  : "GET",
    url     : "/timer/"+tid,
    headers : { authorization : token }
  };
  // console.log("URL: "+options.url);
  setTimeout(function(){
    server.inject(options, function(res) {
      // console.log(" - - -  person should not be anonymous anymore")
      // console.log(res.result);
      t.equal(res.result.person, personid, "Timer created by "+personid);
      t.end();
      server.stop();
    });
  },1000);
});

var newemail   = Math.random()+"unregistered@awesome.io";
var password   = "PinkFluffyUnicorns";
var authHeader = "Basic " + (new Buffer(newemail + ':' + password, 'utf8')).toString('base64');
var options    = {
  method  : "POST",
  url     : "/login-or-register",
  headers : { authorization : authHeader }
};

test(file + " Attempt to /login-or-register fails when no header or payload", function(t){
  server.inject(options, function(res) {
    // console.log(" - - -  person should not be anonymous anymore")
    // console.log(res.result);
    t.equal(res.statusCode, 400, "Fails (as expected - blocked by JOI)");
    t.end();
    server.stop();
  });
});
