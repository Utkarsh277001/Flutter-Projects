const mongoose=require("mongoose")

const gymsData=mongoose.Schema({
    ownerEmail:{
        required:true,
        type:String,
        trim:true,
    },
    gymName:{
         required:true,
        type:String,
        trim:true,
    },
    City:{
         required:true,
        type:String,
        trim:true

    },
    State:{
          required:true,
        type:String,
        trim:true


    },
    perDayRate:{
        required:true,
        type:String,
        trim:true

    },
    Image:{
         required:true,
        type:String,
        trim:true
       
    },
    contactDetails:{
        required:true,
        type:String,
        
    }

},{collection:'gymdata'});

const gymdata=mongoose.model("gymdata",gymsData);
module.exports=gymdata;