const express=require("express");
const { saveOrder } = require("../controller/orderController");

const orderRouter=express.Router();

orderRouter.post("/saveOrder",saveOrder);


module.exports=orderRouter;