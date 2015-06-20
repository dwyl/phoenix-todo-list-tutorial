var Joi = require('joi');
module.exports = {
  payload: {
    person    : Joi.string(), // unique id
    email     : Joi.string().email().required(),
    password  : Joi.string().required().min(4),
    firstname : Joi.string(),
    lastname  : Joi.string(),
    created   : Joi.forbidden() // don't allow people to set this!
  }
}
