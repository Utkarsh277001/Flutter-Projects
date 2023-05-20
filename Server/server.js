const express=require("express");
require("dotenv").config();
const { default: mongoose } = require("mongoose");
const authRouter=require("./Routers/Auth");
var bodyParser = require("body-parser");
const fileUpload=require("express-fileupload");

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
app.use(authRouter);
app.listen(PORT,"0.0.0.0",()=>{
    console.log(`welcome to server ${PORT}`);
  
    
});