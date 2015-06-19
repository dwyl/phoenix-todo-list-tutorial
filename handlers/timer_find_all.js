var ES = require('esta');
var JWTSign  = require('../lib/auth_jwt_sign.js'); // used to sign JWTS duh.

module.exports = function timer_find_all(req, reply, statusCode) {
  if(!statusCode || typeof statusCode === 'undefined') {
    statusCode = 404;
  }
  var query =  {
    "index": process.env.ES_INDEX,
    "type": "timer",
    "field": "person",
    "text": req.auth.credentials.person.toString() // using issuer as the person
  };
  ES.SEARCH(query, function(res) {
    // console.log(res.hits);
    JWTSign(req, function(token, esres){
      if(res.hits.total > 0) {
        // assign a new JWT with the person's ID in it!
        return reply({ timers: res.hits.hits }).header("Authorization", token);
      }
      else {
        return reply(res).code(statusCode).header("Authorization", token);
      }
    }); // Asynchronous
  });
}
