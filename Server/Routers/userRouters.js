const express =require("express");
const { signup, login, forgotPassword } = require("../controller/userController");
const userRouter=express.Router();

userRouter.post("/signup",signup);

userRouter.post("/login",login);

userRouter.post("/forgotPass",forgotPassword);

module.exports=userRouter ;