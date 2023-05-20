
// const DailyGym=require("../Models/daily-gym")


// function saveDailyData async(req,res)=>{
//     try{
//         let newData=await new DailyGym(req.body);

//         newData= await newData.save();

//         console.log("newDsata os ", newData);

//         res.status(201).json("saves successfully ",newData)
//     }
//     catch(error){
//         console.log("error while posting daily gym data ", error.message);
//         res.status(500).json({msg:error.message});
//     }
// }