var test   = require('tape');
var dir   = __dirname.split('/')[__dirname.split('/').length-1];
var file  = dir + __filename.replace(__dirname, '');
var uncache = require('./uncache').uncache;

uncache('../lib/email_welcome'); // clear cached email module
var APIKEY = process.env.MANDRILL_APIKEY; // store for later
process.env.MANDRILL_APIKEY = null; // delete key to force fail
var email  = require('../lib/email_welcome'); // no api key

test(file+" Force Fail in Email", function(t) {
  var person = {
    "email"    : 'bad@example.com',
    "password" : "thiswill400"
  }
  email(person, function(eres) {
    setTimeout(function(){
      console.log(eres);
      t.equal(eres.status, 'error', "Invalid Mandrill Key");
      process.env.MANDRILL_APIKEY = APIKEY; // restore key for next tests
      uncache('../lib/email_welcome'); // clear cached email module
      t.end();
    },50);
  })
});


// now make it pass
test(file+" Email Successfully Sent ", function(t) {
  var person = {
    "email"    : 'dwyl.test+email_welcome' +Math.random()+'@gmail.com',
    "password" : "NotRequiredToTestEmail!"
  }
  process.env.MANDRILL_APIKEY = APIKEY; // restore key for next tests
  uncache('../lib/email_welcome'); // clear cached email module
  var email  = require('../lib/email_welcome'); // WITH api key
  email(person, function(eres){
    console.log(eres);
    t.equal(eres[0].status, 'sent', "Email Sent "+eres[0]._id);
    uncache('../lib/email_welcome'); // clear cached email module
    t.end();
  })
});
