const dailyGym = require("../Models/daily-gym");

const ownerHistory=async(req,res)=>{
      console.log(req.body);
    try {
        let Validation={ownerEmail:req.body.ownerEmail,gymName:req.body.gymName,location:req.body.location,date:req.body.date};
        let data= await dailyGym.find(Validation);
        console.log(data);
       res.status(200).json(data);
      } catch (error) {
        res.status(400).json(error);
     }
}

const AuthenticateVisitor=async(req,res)=>{
     try {
      const { id } = req.params;
      const updatedData = await dailyGym.updateOne({ _id: id }, {
        $set: {
          Visited:req.body.Visited
        }
      });
      if (updatedData.nModified === 0) {
        return res.status(404).json({ msg: "No data found with the given ID" });
      }
      return res.status(200).json({ msg: "Visitor Authenticated successfully" });
    } catch (error) {
      console.log("Error while Authenticating Visitor ", error.message);
      res.status(500).json({ msg: error.message });
    }
}
const GymHistoryRecordForGymOwner =  async (req, res) => {
  const ownerEmail = req.params.ownerEmail;
  const gymName = req.params.gymName;
  const location = req.params.location;

  try {
    const gyms = await dailyGym.find({
      ownerEmail: ownerEmail,
      gymName: gymName,
      location: location,
      Visited:true,
    }).exec();

    if (!gyms || gyms.length === 0) {
      return res.status(404).json({ msg: "No gyms found" });
    }

    res.status(200).json(gyms);
  } catch (error) {
    console.log("Error while getting gym: ", error.message);
    res.status(500).json({ msg: "Error while getting gym" });
  }
}

module.exports={AuthenticateVisitor,ownerHistory,GymHistoryRecordForGymOwner}