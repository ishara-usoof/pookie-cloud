const express = require('express');
const { PORT } = require('./config');
const { databaseConnection } = require('./database');
const { CreateChannel } = require('./utils')
const expressApp = require('./express-app');


console.log("Shopping Service page")
const StartServer = async() => {

    const app = express();
    
    await databaseConnection();

    const channel = await CreateChannel()
    
    await expressApp(app, channel);

    
    app.listen(PORT, () => {
        console.log(`listening to port ${PORT}`);
    })
    .on('error', (err) => {
        console.log(err);
        process.exit();
    })

}

StartServer();
