const Address = require("../Models/address");

const saveAddress=async(req,res)=>{
    console.log("Address Saving");
    try {

      let address=new Address(req.body);
      await address.save().then(()=>{
         console.log("address save"+address);
      
        res.status(200).json({ msg: "Successfully added adress" });
      });
     
    } catch (error) {
      console.log(error);
    }
}


const userAddress =async(req, res) => {
  console.log("Addresses called");
  try {
    const { useremail } = req.params;

    let data = await Address.find({useremail:useremail});
    console.log(data);
     res.status(200).json(data);

 
  } catch (error) {
    res.status(400).json(error);
  }
};

module.exports={
    saveAddress,
    userAddress
}
