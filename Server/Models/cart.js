const mongoose = require('mongoose');

const CartSchema = new mongoose.Schema({
  useremail:String,
  productid:String,
  productname:String,
  price: String,
  image: String,
  
});

const Cart = mongoose.model('Cart', CartSchema);

module.exports = Cart;