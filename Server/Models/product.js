const mongoose = require('mongoose');

const productSchema = new mongoose.Schema({
  productid: String,
  category: String,
  productname:String,
  price: String,
  size: String,
  description: String,
  image: String,
  color: String,
});

const Product = mongoose.model('Product', productSchema);

module.exports = Product;