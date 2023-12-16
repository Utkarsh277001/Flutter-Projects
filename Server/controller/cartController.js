const Cart = require("../Models/cart");



const saveToCart=async(req,res)=>{
    console.log("save to Cart Called");
    try {

      let cart=new Cart(req.body);
      await cart.save().then(()=>{
         console.log("cart save"+cart);
      
        res.status(200).json({ msg: "Successfully uploaded" });
      });
     
    } catch (error) {
      console.log(error);
    }
}

const userCart =async(req, res) => {
  console.log("Cart called");
  try {
    const { useremail } = req.params;

    let data = await Cart.find({useremail:useremail});
    console.log(data);
     res.status(200).json(data);

 
  } catch (error) {
    res.status(400).json(error);
  }
};

const removeItem =async(req, res) => {
  console.log("remove cart item called");
  try {
    const { useremail,productid } = req.body;

    let data = await Cart.deleteOne({useremail:useremail,productid:productid});
    console.log(data);
     res.status(200).json(data);

 
  } catch (error) {
    res.status(400).json(error);
  }
};
module.exports={
    saveToCart,
    userCart,
    removeItem
}