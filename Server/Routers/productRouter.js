const express=require("express");
const { saveProduct, getProduct, deleteProduct } = require("../controller/productController");

const Productrouter=express.Router();

Productrouter.post("/saveProduct",saveProduct);
Productrouter.get("/getProduct",getProduct);
Productrouter.get("/remove/:id",deleteProduct);

module.exports=Productrouter;