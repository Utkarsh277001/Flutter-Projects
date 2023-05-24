const express=require("express");
const { AuthenticateVisitor, ownerHistory } = require("../controller/ownerHistoryController");
const OwnertHistoryRoute=express.Router();

OwnertHistoryRoute.put("/updateVisited/:id",AuthenticateVisitor);

OwnertHistoryRoute.post("/ownerHistory",ownerHistory);

module.exports=OwnertHistoryRoute