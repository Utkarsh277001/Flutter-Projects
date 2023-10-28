const mongoose = require('mongoose');

const productSchema = new mongoose.Schema({
  id: Number,
  category: String,
  price: Number,
  size: String,
  description: String,
  image: String,
  color: String,
});

const Product = mongoose.model('Product', productSchema);

module.exports = Product;