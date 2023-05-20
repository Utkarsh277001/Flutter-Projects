const mongoose=require("mongoose");

//here we create schema of the database so we can buid the structure of the database 
const userSchema=mongoose.Schema({
    name:{
        required:true,
        type:String,
        trim:true,
    },
    email:{
         required:true,
        type:String,
        trim:true,
    },
    password:{
         required:true,
        type:String,
        trim:true

    },  
    age:{
        required:true,
        type:String,
        trim:true
    },  
    gender:{
         required:true,
        type:String,
        trim:true

    }
}
);

//here we create which is use to connect the schema with the database
const User=mongoose.model("User",userSchema);
module.exports=User;