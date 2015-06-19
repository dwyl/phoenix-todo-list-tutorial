// var Boom   = require('boom'); // error handling https://github.com/hapijs/boom
var Hoek   = require('hoek');
var ES     = require('esta');
// var bcrypt = require('bcrypt'); // see: https://github.com/nelsonic/bcrypt
var aguid  = require('aguid'); // import the module we are using to create (GU)IDs
// var JWTSign  = require('../lib/auth_jwt_sign.js'); // used to sign JWTS duh.
// var transfer = require('../lib/transfer_anon_to_registered.js');
var mail  = require('../lib/email_welcome');
console.log(mail)
module.exports = function handler(req, reply) {
  var email;
  if(req.payload && req.payload.email) {
    // var user   = req.payload.email.split('@')[0];
    // var domain = req.payload.email.split('@')[1];
    // // when people use an email such as dwyl.test+sufix@gmail.com
    // email = encodeURIComponent(user) + '@' + domain;
    email = req.payload.email.trim().replace(' ', '+');
  } else {
    email = 'dwyl.test@gmail.com';
  }
  var personid = aguid(email)
  var person =  {
    index: process.env.ES_INDEX,
    type: "person",
    id: personid,
    email: email
  }
  console.log(' - - - - - - - - - - person')
  console.log(person);

  ES.CREATE(person, function (res) {
    console.log(' - - - - - - - - - - - - - - - - - - - ES res:')
    console.log(res);

    Hoek.assert(res._version, 'Person NOT Registered!'); // only if DB fails!
    // transfer any anonymous timers & session to the person

    mail(person, function(eres) {
      console.log(' - - - - - - - - - - email response:');
      console.log(eres);
      console.log(' - - - - - - - - - - - - - - - - - - - - - - - -')
      return reply(eres);
    })
  }); // end ES.CREATE
}
