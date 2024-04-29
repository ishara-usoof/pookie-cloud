const express = require("express");
const cors = require("cors");
const proxy = require("express-http-proxy");

const app = express();

app.use(cors());
app.use(express.json());

app.use("/customer", proxy("http://....elb.amazonaws.com"));
app.use("/shopping", proxy("http://....elb.amazonaws.com"));
app.use("/products", proxy("http://....elb.amazonaws.com")); 

app.listen(80, () => {
  console.log("Gateway is Listening to Port 80");
});
