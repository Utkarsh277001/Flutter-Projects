const mongoose =require("mongoose")

const dailyGymSchema= new mongoose.Schema({
    ownerEmail:{
        required:true,
        type:String
    },
    userEmail:{
         required:true,
         type:String
    },
    Image:{
        type:String
    },
    gymName:{
        type:String
    },
    location:{
        type:String
    },
    date:{
        required:true,
        type:String
    }
    ,time:{
        type:String
    },
    Visited:{
        type:Boolean,
        default:false
    }
}) 


const dailyGym=mongoose.model("dailyGym", dailyGymSchema);

module.exports=dailyGym;
