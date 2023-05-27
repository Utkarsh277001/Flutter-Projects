const express=require("express");
const { getStats,getAllUsers ,getSubscriptionDataByEmail} = require("../controller/superAdminController");
const superAdmin=express.Router();
superAdmin.get("/getStats",getStats);
superAdmin.get("/getAllUsers",getAllUsers);
superAdmin.get("/getSubscriptionData/:Email",getSubscriptionDataByEmail);

module.exports=superAdmin ;