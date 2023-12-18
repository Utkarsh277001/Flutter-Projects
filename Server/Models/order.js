const mongoose = require('mongoose');


const orderSchema = new mongoose.Schema({

  useremail:String,
  productids:String,
  price:String,
  OrderDate: { type: Date, default: Date.now },
  address:String,
  status:String,
  remarks:String,
  
});

const Order = mongoose.model('Order', orderSchema);

module.exports = Order;