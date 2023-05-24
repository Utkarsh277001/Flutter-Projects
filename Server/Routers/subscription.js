const express =require("express");
const { subscriptionDetail, newSubscription } = require("../controller/subscriptiionController");
const subscriptionRouter=express.Router();

subscriptionRouter.post("/new",newSubscription);

subscriptionRouter.get("/:Email",subscriptionDetail);

module.exports=subscriptionRouter ;