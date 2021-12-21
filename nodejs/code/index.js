'use strict';
const { v4: uuidv4 } = require('uuid');

exports.handler = (event, context, callback) => {
    console.log(event.toString());
    console.log(uuidv4());
    callback(null, 'hello world');
}
