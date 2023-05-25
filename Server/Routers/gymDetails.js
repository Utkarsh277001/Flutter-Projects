const express=require("express");
const { GymData, searchCity, allGym, deleteGym, updateGym, ownerGymDetails } = require("../controller/gymDetailscontroller");
const gymDetailsrouter=express.Router();

gymDetailsrouter.post("/gymDatas",GymData);

gymDetailsrouter.get("/searchGym/:City",searchCity);

gymDetailsrouter.get("/allGymData",allGym);

gymDetailsrouter.delete("/deleteGymData/:id",deleteGym);

gymDetailsrouter.put("/updateGymData/:id",updateGym);

gymDetailsrouter.get("/ownerGymDetails/:ownerEmail",ownerGymDetails);

module.exports=gymDetailsrouter ;