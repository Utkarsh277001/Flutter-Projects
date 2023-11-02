const User=require("../Models/User");
const ownerGym = require("../Models/gymOwner");
const gymdata = require("../Models/gymsData");
const subscription = require("../Models/Subscription");
const dailyGym = require("../Models/daily-gym");
// const gymdata = require("../Models/gymsData");
const getStats=async(req,res)=>{
  console.log("stats");
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

const getAllGyms = async (req, res) => {
  // const { Email } = req.params;

  try {
    const gyms = await gymdata.find();
    
    if (!gyms) {
      return res.status(404).json({ msg: "User not found" });
    }

    // const { startDate, endDate } = user;
    res.status(200).json({gyms});
  } catch (error) {
    console.log("Error while getting user: ", error.message);
    res.status(500).json({ msg: "Error while getting user" });
  }
};

const gymOwners = async (req, res) => {
  // const { Email } = req.params;

  try {
    const owners = await ownerGym.find();
    
    if (!owners) {
      return res.status(404).json({ msg: "User not found" });
    }

    // const { startDate, endDate } = user;
    res.status(200).json({owners});
  } catch (error) {
    console.log("Error while getting user: ", error.message);
    res.status(500).json({ msg: "Error while getting user" });
  }
}

const RegisterGymofOwner = async (req, res) => {
  const { Email } = req.params;
  try{
    const gym = await gymdata.find({ownerEmail:Email})
    if (!gym) {
      return res.status(404).json({ msg: "User not found" });
    }
    res.status(200).json({gym});
  }
    catch (error) {
      console.log("Error while getting gym: ", error.message);
    res.status(500).json({ msg: "Error while getting gym" });
  }
}

const UserRecordForSuperAdmin = async (req, res) => {
  const userEmail = req.params.userEmail;
  // Visited: true
  try {
    const gym = await dailyGym.find({userEmail: userEmail, })
    if (!gym || gym.length === 0) {
      return res.status(404).json({ msg: "User not found or no visited gyms" });
    }
    res.status(200).json({gym});
  } catch (error) {
    console.log("Error while getting gym: ", error.message);
    res.status(500).json({ msg: "Error while getting gym" });
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
const GymHistoryRecordForSuperAdmin = async (req, res) => {
  const ownerEmail = req.params.ownerEmail;
  const gymName = req.params.gymName;
  const location = req.params.location;
  // const date = req.params.date;

  try {
    const gyms = await dailyGym.find({
      ownerEmail: ownerEmail,
      gymName: gymName,
      location: location,
      // date: date
    }).exec();

    if (!gyms || gyms.length === 0) {
      return res.status(404).json({ msg: "No gyms found" });
    }

    res.status(200).json(gyms);
  } catch (error) {
    console.log("Error while getting gym: ", error.message);
    res.status(500).json({ msg: "Error while getting gym" });
  }
};

//get a single user data by their email
const getUser = async (req, res) => {
  const {Email} = req.params;
  try{
    const user = await User.find({email:Email})
    if(user === null || user.length === 0){
      return res.status(404).json({ msg: "User not found" });
    }
    res.status(200).json({user});
  }
    catch (error) {
      console.log("Error while getting user: ", error.message);
      res.status(500).json({ msg: "Error while getting user" });
    }
  }





module.exports={getStats,getAllUsers,getSubscriptionDataByEmail,getAllGyms,gymOwners,RegisterGymofOwner,UserRecordForSuperAdmin,GymHistoryRecordForSuperAdmin,getUser,GymHistoryRecordForGymOwner}