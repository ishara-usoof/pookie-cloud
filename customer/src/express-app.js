const express = require('express');
const cors  = require('cors');
const path = require('path');
const { customer, appEvents } = require('./api');
const { CreateChannel, SubscribeMessage } = require('./utils')

module.exports = async (app) => {

    app.use(express.json({limit : '1mb'}));
    app.use(cors());
    app.use(express.static(__dirname + '/public'))

    //api
    // appEvents(app);

    const channel = await CreateChannel()

    
    customer(app, channel);
    // error handling
    
}
