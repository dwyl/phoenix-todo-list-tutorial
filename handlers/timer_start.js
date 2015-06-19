// var JWT   = require('jsonwebtoken');
var ES    = require('esta');
var aguid = require('aguid');
var Hoek  = require('hoek');

module.exports = function(req, reply) {
  var decoded = req.auth.credentials; //JWT.verify(req.headers.authorization, process.env.JWT_SECRET);
  var timer =  {
    index: process.env.ES_INDEX,
    type: "timer",
    person: decoded.person,
    session: decoded.jti, // session id from JWT
    ct: new Date().toISOString(),
    id: aguid()
  }

  for (var k in req.payload){
    timer[k] = req.payload[k]; // extract values from payload
  }
  if(!req.payload.start) { // client did not define the start time
    timer.start = timer.ct; // set it to the same as created
  } else {
    // allow the client to set the started time
  }

  ES.CREATE(timer, function(record) {
    Hoek.merge(record, timer); // http://git.io/Amv6
    // delete the useless _prefixed fields returned by ES
    record.id = record._id;
    delete record._index;
    delete record._type;
    delete record._version;
    delete record.person;
    delete record._id
    reply(record);
  })
}
