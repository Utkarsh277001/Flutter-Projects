const mongoose =require("mongoose")

const Subscription= new mongoose.Schema({
    userId:{
        required:true,
        type:String
    },
    Email:{
        required:true,
        type:String
    },
    startDate:{
      required:true,
      type:String
    },
    endDate:{
        type:String
    }
}) 


const subscription=mongoose.model("subscription", Subscription);

module.exports=subscription;
