const express=require("express");
const { ownerRegister, ownerLogin } = require("../controller/gymOwnerController");
const ownerRoute=express.Router();

ownerRoute.post("/Register",ownerRegister);

ownerRoute.post("/login",ownerLogin);

module.exports=ownerRoute ;