const express=require("express");
const { AuthenticateVisitor, ownerHistory ,GymHistoryRecordForGymOwner} = require("../controller/ownerHistoryController");
const OwnertHistoryRoute=express.Router();

OwnertHistoryRoute.put("/updateVisited/:id",AuthenticateVisitor);

OwnertHistoryRoute.post("/ownerHistory",ownerHistory);
OwnertHistoryRoute.get("GymHistoryRecordForGymOwner/:ownerEmail/:gymName/:location",GymHistoryRecordForGymOwner);

module.exports=OwnertHistoryRoute;