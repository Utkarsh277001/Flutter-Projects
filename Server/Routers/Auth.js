// const express=require("express");
// const bcrypt=require("bcryptjs");
// const User=require("../Models/User");
// // const { saveDailyData } = require("../controller/dailyGym-controller");
// const authRouter=express.Router();
// const DailyGym=require("../Models/daily-gym");
// const dailyGym = require("../Models/daily-gym");
// const subscription = require("../Models/Subscription");
// const ownerGym = require("../Models/gymOwner");
// const gymdata = require("../Models/gymsData");
// const multer=require("multer");
// const cloudinary=require("cloudinary").v2

// cloudinary.config({
//     cloud_name:'dxn2eer5l',
//     api_key:'988655655774785',
//     api_secret:'yMoALeZ9dILSTRBXbHG2-0RB8f4'
// })

// //signUp for Users------------------------------------------------====
// authRouter.post("/api/signup",async(req,res)=>{

// try {
//     //if user is already exist
//     const{name,email,password,age,gender}=req.body;
//     const existuser=await User.findOne({email});
//     if(existuser){
//         return res.status(400).json({msg:"User exist : please sign in"});
//     }
     
//     //if user is not registered then we create the hashed password
//     if(password==""){
//         return res.status(400).json({msg:'password cannot be empty'})
//     }
//     const hashedPassword=await bcrypt.hash(password,10); 

//     //here we create the new user
//     let user=new User({
//         name,
//         email,
//         password:hashedPassword,
//         age,
//         gender

//     });

//     user=await user.save();
//     res.json(user);
    
// } catch (e) {
//     res.status(500).json({error:e.message});
// }

// })

// //login==============================================================================================
// authRouter.post("/api/login",async (req,res)=>{
//     try {

//          const{email,password}=req.body;
//          const user=await User.findOne({email});

//           if(password==""){
//                return res.status(400).json({msg:"Password cannot be empty"});
//          }


//          if(!user){
//                return res.status(400).json({msg:"user doesn't exist..."});
//          }

//     check=await bcrypt.compare(password,user.password);

//     if(!check){
//          return res.status(400).json({msg:"password incorrect"});
//     }
//     // res.status(200).json({msg:'success',verified:email});
//     res.status(200).json({id:user.id,Email:user.email,username:user.name,age:user.age,gender:user.gender,msg:'success'});    

//     } catch (e) {
//         return res.status(400).json({msg:'password is wrong'});
//     }
   
    
// })


// //Daily GYM Backend api========================================================================================
// authRouter.post("/addDailyGym",async(req,res)=>{
//     console.log("req  is --> ", req.body)

        
//     //    const exist=await dailyGym.find({userId});
//     //    if(exist){
//     //     if(exist.date==date){
//     //         res.status(400).json({msg:"Already added"});
//     //     }
//     //    }

       
//         //   const Validation={userId:userId,picNo:picNo,gymName:gymName,location:location,date:date,time:time};
       
//         // const Added=await dailyGym.findOne(req.params.id);
//         // if(error){
//         //       res.status(400).json({msg:"Already Added"});
//         //     //   console.log(error);
//         // }
   
//     try{
//      const{ownerEmail,userEmail,Image,gymName,location,date,time}=req.body;
//       const Validation={userEmail:userEmail,date:date};
//         let exist= await dailyGym.find(Validation);
//         console.log(exist);
//         if(Array.isArray(exist)&&exist.length!=0){
//             return res.status(400).json({msg:"Already Added"});
//         }
// //          .exec().then(docs => {
// //   res.status(400).json({msg:"Already Added"});
// // }).catch(err => {
// //   console.error(err);
// // });
        
//         let newData=  new dailyGym(req.body);
//          await newData.save();
         

//         console.log("newDsata os ", newData);

//         res.json(newData)
//     }
//     catch(error){
//         console.log("error while posting daily gym data ", error.message);
//         res.status(400).json({msg:error.message});
//     }
// })





// authRouter.get("/getAllUsers",async(req,res)=>{
//     // console.log("req is ", req.body)
//     try{
//         let allData=  await User.find();

//         res.status(200).json({allData})
//     }
//     catch(error){
//         console.log("error while getting all users data ", error.message);
//         res.status(500).json({msg:"error while getting all users data "});
//     }
// })

// //owner's gym history
// authRouter.post("/gymDatas/ownerHistory",async(req,res)=>{
//      console.log(req.body);
//     try {
//         let Validation={ownerEmail:req.body.ownerEmail,gymName:req.body.gymName,location:req.body.location,date:req.body.date};
//         let data= await dailyGym.find(Validation);
//         console.log(data);
//        res.status(200).json(data);
//       } catch (error) {
//         res.status(400).json(error);
//     }
// })

// //to get the specific gym
// authRouter.get('/daily-gym/History', async (req, res) => {
//   const fromDate = req.body.fromDate;
//   const toDate = req.body.toDate;

//   try {
//     const dailyGymData = await dailyGym.find({
//       date: {
//         $gte: fromDate,
//         $lte: toDate
//       }
//     });

//     res.json(dailyGymData);
//   } catch (err) {
//     console.error(err.message);
//     res.status(500).send('Server Error');
//   }
// });



// authRouter.get("/getDailyGym",async(req,res)=>{
//     // console.log("req is ", req.body)
//     try{
//         let allData=  await DailyGym.find();

//         res.status(201).json({allData})
//     }
//     catch(error){
//         console.log("error while getting daily gym data ", error.message);
//         res.status(500).json({msg:"error while getting daily data "});
//     }
// })

// authRouter.get("/getDailyGymUser/:id",async(req,res)=>{
//     console.log("req is ", req.params.id)
//     try{
//         let allData=  await DailyGym.find({userEmail:req.params.id});
//         console.log(allData);
//         res.status(200).json(allData)
//     }
//     catch(error){
//         console.log("error while getting daily gym data ", error.message);
//         res.status(500).json({msg:"error while getting daily data "});
//     }
// })


// //User Subscription============================================================================================
// authRouter.post("/subscription",async(req,res)=>{
//     try{
//         const{Email}=req.body;
//         let subscribe= new subscription(req.body);
//         await subscribe.save();
//         console.log("newDsata os ", subscribe);

//         res.status(200).json(subscribe);
//     }catch(error){
//         res.status(500).json({error:error.message})
//     }
// })

// //User Subscription validity Check=============================================================================
// authRouter.get("/subscription/:Email",async(req,res)=>{
//     try{
//         const Email=req.params.Email;
//         console.log(req.params.Email);
//         const member=await subscription.findOne({Email});
//         if(!member){
//             res.status(400).send(json({msg:"error in finding subscription"}));
//         }
//         res.status(200).json({sDate:member.startDate,eDate:member.endDate});
//     }catch(error){
//         res.status(400).json({error:error.message})
//     }
// })


// //GymOwner Register============================================================================================
// authRouter.post("/gymOwnerRegis",async(req,res)=>{
//     try{

//     const{name,email,password,gender,age}=req.body;
//     const existuser=await ownerGym.findOne({email});
//     if(existuser){
//         return res.status(400).json({msg:"GymOwner exist : please sign in"});
//     }
     
//     //if user is not registered then we create the hashed password
//     if(password=="" ||password.length<8){
//         return res.status(400).json({msg:'password cannot be empty or size cannot be less than 8'})
//     }
    
//     const hashedPassword=await bcrypt.hash(password,10);

//     let ownerData=new ownerGym({
//         name,
//         email,
//         password:hashedPassword,
//         gender,
//         age
//     })

//     ownerData.save().then(()=> {return res.status(200).json({msg:"User registered : Login With same credentials"})})
    
//   }
//     catch(err){
//             res.status(500).json({error:e.message});
//     }

// });


// authRouter.post("/gymOwnerlogin",async(req,res)=>{
//     try{
//     const{email,password}=req.body;
    
//          const user=await ownerGym.findOne({email});

//           if(password==""){
//                return res.status(400).json({msg:"Password cannot be empty"});
//          }


//          if(!user){
//                return res.status(400).json({msg:"user doesn't exist , Please Register"});
//          }

//     check=await bcrypt.compare(password,user.password);

//     if(!check){
//          return res.status(400).json({msg:"password incorrect"});
//     }
//     // res.status(200).json({msg:'success',verified:email});
//       res.status(200).json({id:user.id,Email:user.email,username:user.name,age:user.age,gender:user.gender,msg:'success'});    


//     } catch (e) {
//         return res.status(400).json({msg:'password is wrong'});
//     }
// });

// //Api for getting owner's gym details
// authRouter.get("/ownerGymDetails/:ownerEmail",async(req,res)=>{

//     console.log("req is ", req.params.ownerEmail)
//     try{
//         let allData=  await gymdata.find({ownerEmail:req.params.ownerEmail});
//         console.log(allData);
//         res.status(200).json(allData);
//     }
//     catch(error){
//         console.log("error in getting owner's gym Details", error.message);
//         res.status(500).json({msg:"error while getting daily data "});
//     }
// })


// // authRouter.post("/gymDatas", upload.single("Image"),async(req,res)=>{
// //     console.log("req  is --> ", req.body.ownerEmail)

// //     try {

// //         // const{ownerEmail,gymName,City}=req.body;
// //       let Validation={ownerEmail:req.body.ownerEmail,gymName:req.body.gymName};
// //         let data= await gymdata.find(Validation);
// //         console.log(data);
// //         if(Array.isArray(data)&&data.length!=0){
// //             return res.status(400).json({msg:"Already Added"});
// //         }
        

// //          const datas = new gymdata({
// //       ownerEmail: req.body.ownerEmail,
// //       gymName: req.body.gymName,
// //       City: req.body.City,
// //       State: req.body.State,
// //       perDayRate: req.body.perDayRate,
// //       Image: {
// //         data: req.file.filename,
// //       },
// //       contactDetails: req.body.contactDetails,
// //     });

// //     datas.save().then(() => {
// //       res.status(200).json({ msg: "Successfully uploaded" });
// //     });

// //     console.log(datas);
// //   } catch (error) {
// //     console.log("error while posting gym data ", error.message);
// //     res.status(400).json({ msg: error.message });
// //   }
// // });

// authRouter.post("/gymDatas", async(req,res)=>{

//     console.log(req.body);
//     try {
//         let Validation={ownerEmail:req.body.ownerEmail,gymName:req.body.gymName};
//         let data= await gymdata.find(Validation);
//         console.log(data);
//         if(Array.isArray(data)&&data.length!=0){
//             return res.status(400).json({msg:"Already Added"});
//         }
//          const file=req.files.Photo;
//     cloudinary.uploader.upload(file.tempFilePath,(err,result)=>{console.log(result);
//     const datas = new gymdata({
//       ownerEmail: req.body.ownerEmail,
//       gymName: req.body.gymName,
//       City: req.body.City,
//       State: req.body.State,
//       perDayRate: req.body.perDayRate,
//       Image: result.url,
//       contactDetails: req.body.contactDetails,
//     });

//     datas.save().then(() => {
//       res.status(200).json({ msg: "Successfully uploaded" });
//     });
// });
        
//     } catch (error) {
//         res.status(400).json(error);
//     }
   

// })

// authRouter.get("/searchGym/:City",async(req,res)=>{
//     console.log(req.params.City);
// try {
//      let data=await gymdata.find({City:req.params.City});
//       console.log(data);
//         res.status(200).json(data)
// } catch (error) {
//      res.status(400).json(error);
// }
    
// });

// authRouter.put("/updateVisited/:id", async (req, res) => {
//     try {
//       const { id } = req.params;
//       const updatedData = await dailyGym.updateOne({ _id: id }, {
//         $set: {
//           Visited:req.body.Visited
//         }
//       });
//       if (updatedData.nModified === 0) {
//         return res.status(404).json({ msg: "No data found with the given ID" });
//       }
//       return res.status(200).json({ msg: "Visitor Authenticated successfully" });
//     } catch (error) {
//       console.log("Error while Authenticating Visitor ", error.message);
//       res.status(500).json({ msg: error.message });
//     }
//   });

// authRouter.get("/allGymData", async (req, res) => {
//   try {
//    const data = await gymdata.find();
//     res.status(200).json(data);
//   } catch (error) {
//     console.log("error while retrieving gym data ", error.message);
//     res.status(400).json({ msg: error.message });
//   }
// });

// authRouter.delete("/deleteGymData/:id", async (req, res) => {
//     try {
//       const { id } = req.params;
//       const deletedData = await gymdata.deleteOne({ _id: id });
//       if (deletedData.deletedCount === 0) {
//         return res.status(404).json({ msg: "No data found with the given ID" });
//       }
//       return res.status(200).json({ msg: "Data deleted successfully" });
//     } catch (error) {
//       console.log("Error while deleting gym data ", error.message);
//       res.status(500).json({ msg: error.message });
//     }
//   });
  
//   authRouter.put("/updateGymData/:id", async (req, res) => {
//     try {
//       const { id } = req.params;
//       const updatedData = await gymdata.updateOne({ _id: id }, {
//         $set: {
//           gymName: req.body.gymName,
//           City: req.body.City,
//           State: req.body.State,
//           perDayRate: req.body.perDayRate,
//           contactDetails: req.body.contactDetails,
//         }
//       });
//       if (updatedData.nModified === 0) {
//         return res.status(404).json({ msg: "No data found with the given ID" });
//       }
//       return res.status(200).json({ msg: "Data updated successfully" });
//     } catch (error) {
//       console.log("Error while updating gym data ", error.message);
//       res.status(500).json({ msg: error.message });
//     }
//   });



//   authRouter.get("/getStats", async (req, res) => {
//     try {
//       const userCount = await User.countDocuments();
//       const gymOwnerCount = await ownerGym.countDocuments();
//       const gymCount = await gymdata.countDocuments();
  
//       res.status(200).json({
//         totalUsers: userCount,
//         totalGymOwners: gymOwnerCount,
//         totalGyms: gymCount
//       });
//     } catch (error) {
//       console.log("Error while getting stats: ", error.message);
//       res.status(500).json({ msg: "Error while getting stats" });
//     }
//   });
  
// module.exports=authRouter;