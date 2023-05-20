const mongoose =require("mongoose")


const Gymowner=mongoose.Schema({
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

    },  age:{
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
const ownerGym=mongoose.model("ownerGym",Gymowner);
module.exports=ownerGym;