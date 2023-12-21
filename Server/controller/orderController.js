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

  const userOrder =async(req, res) => {
  console.log("OrderHis. called");
  try {
    const { useremail } = req.params;

    let data = await Order.find({useremail:useremail});
    console.log(data);
     res.status(200).json(data);

 
  } catch (error) {
    res.status(400).json(error);
  }
}


module.exports={
    saveOrder,userOrder
}