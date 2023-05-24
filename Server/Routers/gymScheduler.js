const express =require("express");
const { addDailyGym, AllUser, History, DailyGym, dailyUser } = require("../controller/gymScheduleController");
const gymSchRouter=express.Router();

gymSchRouter.post("/addDailyGym",addDailyGym);

gymSchRouter.get("/getAllUsers",AllUser);

gymSchRouter.get('/daily-gym/History',History);

gymSchRouter.get("/getDailyGym",DailyGym);

gymSchRouter.get("/getDailyGymUser/:id",dailyUser);

module.exports=gymSchRouter;