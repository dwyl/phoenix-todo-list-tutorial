var ES = require('esta');
var dir    = __dirname.split('/')[__dirname.split('/').length-1];
var file   = dir + __filename.replace(__dirname, '') + " -> ";

module.exports = function(req, reply) {
  var record =  {
    index: process.env.ES_INDEX,
    type: "timer",
    id: req.params.id
  }

  ES.READ(record, function(res) {
    if(res.found) {
      return reply(res._source);
    }
    else {
      return reply(res).code(404);
    }
  });
}
