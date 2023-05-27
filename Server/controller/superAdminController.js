const User=require("../Models/User");
const ownerGym = require("../Models/gymOwner");
const gymdata = require("../Models/gymsData");
const subscription = require("../Models/Subscription");
const getStats=async(req,res)=>{
    try {
        const userCount = await User.countDocuments();
        const gymOwnerCount = await ownerGym.countDocuments();
        const gymCount = await gymdata.countDocuments();
    
        res.status(200).json({
          totalUsers: userCount,
          totalGymOwners: gymOwnerCount,
          totalGyms: gymCount
        });
      } catch (error) {
        console.log("Error while getting stats: ", error.message);
        res.status(500).json({ msg: "Error while getting stats" });
      }
    
}

const getAllUsers = async (req, res) => {
  try {
    const users = await User.find({},);
    res.status(200).json(users);
  } catch (error) {
    console.log("Error while getting users: ", error.message);
    res.status(500).json({ msg: "Error while getting users" });
  }
};

//display diaload box for each user and gave the subscription data
const getSubscriptionDataByEmail = async (req, res) => {
  const { Email } = req.params;

  try {
    const user = await subscription.findOne({ Email : Email});
    
    if (!user) {
      return res.status(404).json({ msg: "User not found" });
    }

    const { startDate, endDate } = user;
    res.status(200).json({ startDate, endDate });
  } catch (error) {
    console.log("Error while getting user: ", error.message);
    res.status(500).json({ msg: "Error while getting user" });
  }
};


module.exports={getStats,getAllUsers,getSubscriptionDataByEmail}