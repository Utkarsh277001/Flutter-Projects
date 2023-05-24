
const gymdata = require("../Models/gymsData");

const cloudinary=require("cloudinary").v2

cloudinary.config({
    cloud_name:'dxn2eer5l',
    api_key:'988655655774785',
    api_secret:'yMoALeZ9dILSTRBXbHG2-0RB8f4'
})

const GymData=async(req,res)=>{
     console.log(req.body);
    try {
        let Validation={ownerEmail:req.body.ownerEmail,gymName:req.body.gymName};
        let data= await gymdata.find(Validation);
         console.log(data);
        if(Array.isArray(data)&&data.length!=0){
            return res.status(400).json({msg:"Already Added"});
        }
         const file=req.files.Photo;
    cloudinary.uploader.upload(file.tempFilePath,(err,result)=>{console.log(result);
    const datas = new gymdata({
      ownerEmail: req.body.ownerEmail,
      gymName: req.body.gymName,
      City: req.body.City,
      State: req.body.State,
      perDayRate: req.body.perDayRate,
      Image: result.url,
      contactDetails: req.body.contactDetails,
    });

    datas.save().then(() => {
      res.status(200).json({ msg: "Successfully uploaded" });
    });
    });
        
    } catch (error) {
        res.status(400).json(error);
    }
   
}

const searchCity=async(req,res)=>{

     console.log(req.params.City);
try {
     let data=await gymdata.find({City:req.params.City});
      console.log(data);
        res.status(200).json(data)
} catch (error) {
     res.status(400).json(error);
}

}

const deleteGym=async (req,res)=>{
     try {
      const { id } = req.params;
      const deletedData = await gymdata.deleteOne({ _id: id });
      if (deletedData.deletedCount === 0) {
        return res.status(404).json({ msg: "No data found with the given ID" });
      }
      return res.status(200).json({ msg: "Data deleted successfully" });
    } catch (error) {
      console.log("Error while deleting gym data ", error.message);
      res.status(500).json({ msg: error.message });
    }

}

const allGym=async (req,res)=>{
    try {
   const data = await gymdata.find();
    res.status(200).json(data);
  } catch (error) {
    console.log("error while retrieving gym data ", error.message);
    res.status(400).json({ msg: error.message });
  }
}

const updateGym=async(req,res)=>{
     try {
      const { id } = req.params;
      const updatedData = await gymdata.updateOne({ _id: id }, {
        $set: {
          gymName: req.body.gymName,
          City: req.body.City,
          State: req.body.State,
          perDayRate: req.body.perDayRate,
          contactDetails: req.body.contactDetails,
        }
      });
      if (updatedData.nModified === 0) {
        return res.status(404).json({ msg: "No data found with the given ID" });
      }
      return res.status(200).json({ msg: "Data updated successfully" });
    } catch (error) {
      console.log("Error while updating gym data ", error.message);
      res.status(500).json({ msg: error.message });
    }
}

module.exports={GymData,updateGym,allGym,deleteGym,searchCity};
