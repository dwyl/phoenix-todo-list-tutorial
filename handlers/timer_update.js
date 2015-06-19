// var JWT   = require('jsonwebtoken');
var ES    = require('esta');
var aguid = require('aguid');
var Hoek  = require('hoek');

module.exports = function(req, reply) {
  var decoded = req.auth.credentials;
  var timer =  {
    index:   process.env.ES_INDEX,
    type:    "timer",
    id: req.payload.id
  }
  // FIRST lookup the timer to see if it exists
  ES.READ(timer, function(esres) {
    // console.log(esres);
    // console.log(" - - - - - - - - - - - - ");
    if(esres.found){
      for (var k in esres._source) {
        timer[k] = esres._source[k]; // extract values from existing record
      }
      // UPDATE the relevant fields:
      for (var j in req.payload) {
        timer[j] = req.payload[j]; // extract values from payload
      }
    }
    else { // create a NEW Timer Record:
      timer.person  = decoded.person;
      timer.session = decoded.jti; // session id from JWT
      timer.ct      = new Date().toISOString();
      //a timer should ALWAYS have a start time
      if(!req.payload.start) { // client did not define the start time
        timer.start = timer.ct; // set it to the same as created
      } else {
        // allow the client to set (and UPDATE!) the started time
      }
      // UPDATE the relevant fields:
      for (var l in req.payload) {
        timer[l] = req.payload[l]; // extract values from payload
      }
      // BUT don't allow setting id for *NEW* Timers
      timer.id = aguid();
    }


    ES.UPDATE(timer, function(record) {
      Hoek.merge(record, timer); // http://git.io/Amv6
      record.id = record._id;
      delete record._index;
      delete record._type;
      delete record._version;
      delete record.person;
      delete record._id
      reply(record);
    })
  });
  // // delete the excess fields so we don't bloat the record:
  // delete req.payload._index;
  // delete req.payload._type;
  // delete req.payload._version;
}
