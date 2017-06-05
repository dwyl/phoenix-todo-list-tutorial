// if you want to run the Just the API server without front-end run this file
var Hapi    = require('hapi');
var Basic   = require('hapi-auth-basic');
var AuthJWT = require('hapi-auth-jwt2')
var Joi     = require('joi');
var lout    = require('lout');
var ES      = require('esta');  // https://github.com/nelsonic/esta
var port    = process.env.PORT || 1337; // heroku define port or use 1337
var server  = new Hapi.Server();

server.connection({ port: port });

var routes = require('./routes.js');

server.register([ {register: Basic},
  {register: AuthJWT}, { register: lout }], function (err) {

  server.auth.strategy('basic', 'basic', {
    validateFunc: require('./lib/auth_basic_validate.js')
  });

  // dont force people to set env vars. https://github.com/ideaq/time/issues/93
  process.env.JWT_SECRET = process.env.JWT_SECRET || 'not-so-secret';
  
  server.auth.strategy('jwt', 'jwt', 'required',  {
    key: process.env.JWT_SECRET,
    validateFunc: require('./lib/auth_jwt_validate.js')
  });

  server.route(routes);
});

server.start();
console.log('Now Visit: http://localhost:'+port);

module.exports = server;
