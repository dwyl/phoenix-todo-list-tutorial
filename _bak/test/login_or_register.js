var test   = require('tape');
var server = require("../../web.js");
var dir    = __dirname.split('/')[__dirname.split('/').length-1];
var file   = dir + __filename.replace(__dirname, '');
var email  = 'dwyl.test+login_or_register' +Math.random()+'@gmail.com';
var person = { // we'll be re-using these below ...
  "email"    : email,
  "password" : "PinkFluffyUnicorns"
}
var options = {
  method  : "POST",
  url     : "/login-or-register",
  payload : person
};

test(file+" Bad request to /login-or-register (should fail)", function(t) {
  var options = {
    method  : "POST",
    url     : "/login-or-register"
    // NO PAYLOAD
  };
  server.inject(options, function(res) {
    // console.log(res);
    t.equal(res.statusCode, 400, res.result.message+" (fails JOI Validation)");
    t.end();
    server.stop();
  });
});

test(file+" Register a new person", function(t) {
  server.inject(options, function(res) {
    t.equal(res.statusCode, 200, "Person registration is succesful");
    t.end();
    server.stop();
  });
});

test(file+" Login with existing person", function(t) {
  var authHeader = "Basic " + (new Buffer(person.email + ':' + person.password, 'utf8')).toString('base64');
  options.headers = { authorization : authHeader };
  server.inject(options, function(res) {
    // console.log(res.result);
    t.equal(res.statusCode, 200, "Everything is Awesome");
    t.end();
    server.stop();
  });
});

test(file + "Attempt to /login-or-register without any auth", function(t) {
  var options    = {
    method  : "POST",
    url     : "/login-or-register"
  };
  server.inject(options, function(res) {
    // console.log(res.result)
    t.equal(res.statusCode, 400, "Fails (as expected) MSG: " + res.result.message);
    t.end();
    server.stop();
  });
});
