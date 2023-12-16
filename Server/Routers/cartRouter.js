const express=require("express");
const { saveToCart, userCart, removeItem } = require("../controller/cartController");
const cartRouter=express.Router();

cartRouter.post("/savetocart",saveToCart);
cartRouter.get("/userCart/:useremail",userCart);
cartRouter.post("/removeItem",removeItem);

module.exports=cartRouter;