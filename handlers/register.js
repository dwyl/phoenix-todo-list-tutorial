var Boom   = require('boom'); // error handling https://github.com/hapijs/boom
var Hoek   = require('hoek');
var ES     = require('esta');
var bcrypt = require('bcrypt'); // see: https://github.com/nelsonic/bcrypt
var aguid  = require('aguid'); // import the module we are using to create (GU)IDs
var JWTSign  = require('../lib/auth_jwt_sign.js'); // used to sign JWTS duh.
var transfer = require('../lib/transfer_anon_to_registered.js');
var email  = require('../lib/email_welcome');

module.exports = function handler(req, reply) {
  var personid = aguid(req.payload.email)
  var person =  {
    index: process.env.ES_INDEX,
    type: "person",
    id: personid,
    email: req.payload.email
  }
  // check if the person with email address has already registered:
  ES.READ(person, function(res) {
    if(res.found) { // return Boom 400 user already registered!
      return reply(Boom.badRequest('Email address already registered'));
    }
    else { // person with that email has yet not registered so hass password
      bcrypt.genSalt(12, function(err, salt) { //encrypt the password
        // see: https://github.com/nelsonic/bcrypt
        bcrypt.hash(req.payload.password, salt, function(err, hash) {

          person.password = hash;

          ES.CREATE(person, function (res) {

            Hoek.assert(res.created, 'Person NOT Registered!'); // only if DB fails!
            // transfer any anonymous timers & session to the person
            console.log(' - - - - - - - - - - person')
            console.log(person);
            console.log(' - - - - - - - - - - email success')
            email(person, function(err, eres){
              console.log(eres);
              if(req.headers.authorization){
                // console.log("AUTH TOKEN:"+req.headers.authorization);
                return transfer(req, reply);
              }
              else {
                JWTSign(req, function(token, esres){
                  return reply(esres).header("Authorization", token);
                }); // Asynchronous
              }
            })
          }); // end ES.CREATE
        }); // end bcrypt.hash
      }); // end bcrypt.genSalt
    }
  });
}
