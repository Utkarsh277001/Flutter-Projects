const express=require("express");
const { ownerRegister, ownerLogin, forgotPassword } = require("../controller/gymOwnerController");
const ownerRoute=express.Router();

ownerRoute.post("/Register",ownerRegister);

ownerRoute.post("/login",ownerLogin);

ownerRoute.post("/forgotPass",forgotPassword);


module.exports=ownerRoute ;