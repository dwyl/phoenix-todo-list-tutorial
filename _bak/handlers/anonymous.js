var JWT = require('../lib/auth_jwt_sign.js');
module.exports = function handler(req, reply) {
  JWT(req, function(token, esres){
    return reply(esres).header("Authorization", token);
  }); // Async
}
