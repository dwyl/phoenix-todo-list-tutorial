var Joi = require('joi');
module.exports = {
  payload: {
    person:  Joi.forbidden(),
    desc:    Joi.string().optional(),
    ct: Joi.forbidden(), // don't allow people to set this!
    start:   Joi.date().iso(),
    end:     Joi.date().iso().optional(),
    endtimestamp: Joi.string().optional(), // convenience
    aid:     Joi.string(),
    session: Joi.string().optional(),
    id: Joi.string().optional(),
    elapsed: Joi.number().optional(), // in miliseconds
    took: Joi.string().optional()
  }
}
