const express=require("express");
const { saveAddress, userAddress } = require("../controller/addressController");

const addressRouter=express.Router();

addressRouter.post("/saveAddress",saveAddress);
addressRouter.get("/userAddress/:useremail",userAddress);


module.exports=addressRouter;