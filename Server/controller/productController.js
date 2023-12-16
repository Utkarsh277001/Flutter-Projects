const Product = require("../Models/product");
const cloudinary=require("cloudinary").v2

cloudinary.config({
    cloud_name:'dxn2eer5l',
    api_key:'988655655774785',
    api_secret:'yMoALeZ9dILSTRBXbHG2-0RB8f4'
})

 const saveProduct =async(req, res) => {
  console.log("Product registration initiated.");
  try {
    let Validation = {
      productid: req.body.productId,
    };

    let data = await Product.findOne(Validation);
    console.log(data);

    if (data) {
      return res.status(400).json({ msg: "Already Added" });
    }
  const file = req.files.Photo;
    cloudinary.uploader.upload(file.tempFilePath, (err, result) => {
      console.log(result);
      const datas = new Product({
        productid: req.body.productId,
        productname:req.body.productname,
        category: req.body.category,
        price: req.body.price,
        size: req.body.size,
        description:req.body.description,
        image: result.url,
        color: req.body.color
      });

      datas.save().then(() => {
        res.status(200).json({ msg: "Successfully uploaded" });
        console.log("uploaded");
      });
    });
  } catch (error) {
    res.status(400).json(error);
  }
};

// Create a new product
const getProduct= async (req, res) => {
 console.log("stats");
     try {
    const product = await Product.find({},);
    console.log(product);
    res.status(200).json(product);
  } catch (error) {
    console.log("Error while getting users: ", error.message);
    res.status(500).json({ msg: "Error while getting users" });
  }
    
};

const deleteProduct=async (req,res)=>{
  console.log("deleting product");
     try {
      const { id } = req.params;
      const deletedData = await Product.deleteOne({ productid: id });
      if (deletedData.deletedCount === 0) {
        return res.status(404).json({ msg: "No data found with the given ID" });
      }
      return res.status(200).json({ msg: "Data deleted successfully" });
    } catch (error) {
      console.log("Error while deleting product data ", error.message);
      res.status(500).json({ msg: error.message });
    }

}

module.exports={
    saveProduct,
    getProduct,
    deleteProduct
}