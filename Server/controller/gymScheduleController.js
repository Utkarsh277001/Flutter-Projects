const dailyGym = require("../Models/daily-gym");

const addDailyGym=async(req,res)=>{
     console.log("req  is --> ", req.body)

    try{
     const{ownerEmail,userEmail,Image,gymName,location,date,time}=req.body;
      const Validation={userEmail:userEmail,date:date};
        let exist= await dailyGym.find(Validation);
        console.log(exist);
        if(Array.isArray(exist)&&exist.length!=0){
            return res.status(400).json({msg:"Already Added"});
         }

        
        let newData=  new dailyGym(req.body);
         await newData.save();
         

        console.log("newDsata os ", newData);

        res.json(newData)
    }
    catch(error){
        console.log("error while posting daily gym data ", error.message);
        res.status(400).json({msg:error.message});
    }
}

const AllUser=async(req,res)=>{

     try{
        let allData=  await User.find();

        res.status(200).json({allData})
    }
    catch(error){
        console.log("error while getting all users data ", error.message);
        res.status(500).json({msg:"error while getting all users data "});
    }

}

const History=async(req,res)=>{
    const fromDate = req.body.fromDate;
  const toDate = req.body.toDate;

  try {
    const dailyGymData = await dailyGym.find({
      date: {
        $gte: fromDate,
        $lte: toDate
      }
    });

    res.json(dailyGymData);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server Error');
  }
    
}

const DailyGym=async(req,res)=>{
    try{
        let allData=  await dailyGym.find();

        res.status(201).json({allData})
    }
    catch(error){
        console.log("error while getting daily gym data ", error.message);
        res.status(500).json({msg:"error while getting daily data "});
    }
    
}

const dailyUser=async(req,res)=>{

    console.log("req is ", req.params.id)
    try{
        let allData=  await dailyGym.find({userEmail:req.params.id});
        console.log(allData);
        res.status(200).json(allData)
    }
    catch(error){
        console.log("error while getting daily gym data ", error.message);
        res.status(500).json({msg:"error while getting daily data "});
    }

    
}

const slot=async(req,res)=>{
  console.log("slot availability");
  console.log(req.body);
  try {
    const parameter={date:req.body.date,time:req.body.time,gymName:req.body.gymName};
    const slotbooked = await dailyGym.countDocuments(parameter);
    console.log(slotbooked)
    res.status(200).json({
          slotBooked:slotbooked 
        });
    
  } catch (error) {
      console.log("Error while getting stats: ", error.message);
        res.status(500).json({ msg: "Error while getting stats" });
  }
}

module.exports={addDailyGym,AllUser,History,DailyGym,dailyUser,slot};

