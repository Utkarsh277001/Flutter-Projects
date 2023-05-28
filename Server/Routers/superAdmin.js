const express=require("express");
const { getStats,getAllUsers ,getSubscriptionDataByEmail,getAllGyms, gymOwners,RegisterGymofOwner} = require("../controller/superAdminController");
const superAdmin=express.Router();
superAdmin.get("/getStats",getStats);
superAdmin.get("/getAllUsers",getAllUsers);
superAdmin.get("/getSubscriptionData/:Email",getSubscriptionDataByEmail);
superAdmin.get("/getAllGyms",getAllGyms);
superAdmin.get("/gymOwners",gymOwners);
superAdmin.get("/RegisterGymofOwner/:Email",RegisterGymofOwner);

module.exports=superAdmin ;