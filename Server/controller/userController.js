const User=require("../Models/User");
const bcrypt=require("bcryptjs");

const signup=async(req,res)=>{
    try {
    //if user is already exist
    const{name,email,password,age,gender}=req.body;
    const existuser=await User.findOne({email});
    if(existuser){
        return res.status(400).json({msg:"User exist : please sign in"});
    }
     
    //if user is not registered then we create the hashed password
    if(password==""){
        return res.status(400).json({msg:'password cannot be empty'})
    }
    const hashedPassword=await bcrypt.hash(password,10); 

    //here we create the new user
    let user=new User({ 
        name,
        email,
        password:hashedPassword,
        age,
        gender

    });

    user=await user.save();
    res.json(user);
    
} catch (e) {
    res.status(500).json({error:e.message});
}
}


//Login Controller
const login=async(req,res)=>{

    try {

         const{email,password}=req.body;
         const user=await User.findOne({email});

          if(password==""){
               return res.status(400).json({msg:"Password cannot be empty"});
         }


         if(!user){
               return res.status(400).json({msg:"user doesn't exist..."});
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
    const user = await User.findOne({ email });

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

module.exports={signup,login,forgotPassword}