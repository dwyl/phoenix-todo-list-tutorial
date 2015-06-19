var ES    = require('esta');

module.exports = function logout(req, reply) {
  var session = {
    index : process.env.ES_INDEX,
    type  : "session",
    id    : req.auth.credentials.jti,
    ended : new Date().toISOString()
  }
  ES.UPDATE(session, function(res){
    return reply(res);
  });
}
