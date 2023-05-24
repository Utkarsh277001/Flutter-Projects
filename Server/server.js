const express=require("express");
require("dotenv").config();
const { default: mongoose } = require("mongoose");
const authRouter=require("./Routers/Auth");
var bodyParser = require("body-parser");
const fileUpload=require("express-fileupload");
const gymDetailsrouter = require("./Routers/gymDetails");
const userRouter = require("./Routers/userRouters");
const subscriptionRouter = require("./Routers/subscription");
const ownerRoute = require("./Routers/gymOwner");
const OwnertHistoryRoute = require("./Routers/ownerHistory");
const gymSchRouter = require("./Routers/gymScheduler");

const dbLink = process.env.Link;
const PORT=process.env.PORT;
const app=express();

mongoose.connect(dbLink).then(()=>{
    console.log("Connection to database is sucessful");
}).catch((e)=>{
    console.log(e);
});

app.use(fileUpload({
useTempFiles:true
}))
app.use(express.json());
// app.use(authRouter);
app.get("/",(req,res)=>{
    res.send("hello");
})
app.use("/gymInfo",gymDetailsrouter);
app.use("/api",userRouter);
app.use("/subscription",subscriptionRouter);
app.use("/gymOwner",ownerRoute);
app.use("/gymData",OwnertHistoryRoute);
app.use("/schedule",gymSchRouter);
// app.use();
app.listen(PORT,"0.0.0.0",()=>{
    console.log(`welcome to server ${PORT}`);
  
    
});