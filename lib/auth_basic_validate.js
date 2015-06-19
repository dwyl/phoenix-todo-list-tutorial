var ES     = require('esta');
var Bcrypt = require('bcrypt');
var aguid  = require('aguid'); // https://github.com/ideaq/aguid

module.exports = function validate (email, password, callback) {

  var person =  {
    index: process.env.ES_INDEX,
    type: "person",
    id: aguid(email)
  }

  ES.READ(person, function(res) {
    if(res.found) { // compare to bcrypt hash on file
      Bcrypt.compare(password, res._source.password, function (err, isValid) {
        callback(err, isValid, { id: res._id, email: res._source.email });
      });
    } else {
      callback(null, false); // person has not registered
    }
  });
};
