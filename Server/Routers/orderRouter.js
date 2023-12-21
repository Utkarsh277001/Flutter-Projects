const express=require("express");
const { saveOrder, userOrder } = require("../controller/orderController");

const orderRouter=express.Router();

orderRouter.post("/saveOrder",saveOrder);

orderRouter.get("/orderHis/:useremail",userOrder);


module.exports=orderRouter;