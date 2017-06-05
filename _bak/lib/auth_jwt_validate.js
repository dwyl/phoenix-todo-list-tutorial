var ES = require('esta');

var validateFunc = function (decoded, request, callback) {

  var session = {
    index : process.env.ES_INDEX,
    type  : "session",
    id    : decoded.jti  // use SESSION ID as key for sessions
  } // jti? >> http://self-issued.info/docs/draft-ietf-oauth-json-web-token.html#jtiDef

  ES.READ(session, function(res){
    if(res.found && !res._source.ended) {
      return callback(null, true); // session is valid
    }
    else {
      return callback(null, false); // session expired
    }
  });
};

module.exports = validateFunc;
