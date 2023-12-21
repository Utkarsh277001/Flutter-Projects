const ownerGym = require("../Models/gymOwner");
const bcrypt=require("bcryptjs");

const ownerRegister=async(req,res)=>{
      try{

    const{name,email,password,gender,age}=req.body;
    const existuser=await ownerGym.findOne({email});
    if(existuser){
        return res.status(400).json({msg:"GymOwner exist : please sign in"});
    }
     
    //if user is not registered then we create the hashed password
    if(password=="" ||password.length<8){
        return res.status(400).json({msg:'password cannot be empty or size cannot be less than 8'})
     }
    
    const hashedPassword=await bcrypt.hash(password,10);

    let ownerData=new ownerGym({
        name,
        email,
        password:hashedPassword,
        gender,
        age
    })

    ownerData.save().then(()=> {return res.status(200).json({msg:"User registered : Login With same credentials"})})
    
  }
    catch(err){
            res.status(500).json({error:e.message});
    }
}

const ownerLogin=async(req,res)=>{
       try{
    const{email,password}=req.body;
    
         const user=await ownerGym.findOne({email});

          if(password==""){
               return res.status(400).json({msg:"Password cannot be empty"});
         }


         if(!user){
               return res.status(400).json({msg:"user doesn't exist , Please Register"});
         }

    check=await bcrypt.compare(password,user.password);

    if(!check){
         return res.status(400).json({msg:"password incorrect"});
    }
    // res.status(200).json({msg:'success',verified:email});
      res.status(200).json({id:user.id,Email:user.email,username:user.name,age:user.age,gender:user.gender,msg:'success'});    


    } catch (e) {
        return res.status(400).json({msg:'password is wrong'});
    }
}

const forgotPassword = async (req, res) => {
  try {
    const { email, newPassword } = req.body;
    const user = await ownerGym.findOne({ email });

    if (!user) {
      return res.status(400).json({ msg: "User doesn't exist..." });
    }

    // Update the user's password
    user.password = await bcrypt.hash(newPassword, 10);
    await user.save();

    res.status(200).json({
      id: user.id,
      email: user.email,
      username: user.name,
      age: user.age,
      gender: user.gender,
      msg: 'Password updated successfully',
    });
  } catch (e) {
    return res.status(400).json({ msg: 'Failed to update password' });
  }
};

module.exports={
    ownerRegister,
    ownerLogin,forgotPassword
}