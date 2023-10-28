const express =require("express");
const { addDailyGym, AllUser, History, DailyGym, dailyUser, slot } = require("../controller/gymScheduleController");
const gymSchRouter=express.Router();

gymSchRouter.post("/addDailyGym",addDailyGym);

gymSchRouter.get("/getAllUsers",AllUser);

gymSchRouter.get('/daily-gym/History',History);

gymSchRouter.get("/getDailyGym",DailyGym);

gymSchRouter.get("/getDailyGymUser/:id",dailyUser);

gymSchRouter.post("/slotdata",slot);

module.exports=gymSchRouter ;