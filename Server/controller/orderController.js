const Order = require("../Models/order");

const saveOrder=async(req,res)=>{
    console.log("Saving Order");
    try {

      let order=new Order(req.body);
      await order.save().then(()=>{
         console.log("order save "+order);
      
        res.status(200).json({ msg: "Order placed Successfully" });
      });
     
    } catch (error) {
      console.log(error);
    }
}

module.exports={
    saveOrder
}