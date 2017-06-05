// Why isn't EVERYONE Doing it this way? Am I missing smth? http://git.io/vvfQF
var auth     = require('../lib/auth_basic_validate');
var login    = require('./login');
var register = require('./register');
var Hoek  = require('hoek');

module.exports = function handler(req, reply) {
  // use auth plugin to check if the person has the correct email & password
  // console.log(req.payload);
  auth(req.payload.email, req.payload.password, function(err,isValid,creds){
    // if no errors and password isValid we can login the person
    // Hoek.assert(err || !isValid, 'Login Error'); // JWT fails
    if(!err && isValid) {
      return login(req, reply);
    }
    else {
      return register(req, reply);
    }
  })
} // #LESSisMOAR!
