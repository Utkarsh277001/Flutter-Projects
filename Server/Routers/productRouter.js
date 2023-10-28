const express=require("express");
const { saveProduct, getProduct } = require("../controller/productController");

const Productrouter=express.Router();

Productrouter.post("/saveProduct",saveProduct);
Productrouter.get("/getProduct",getProduct);