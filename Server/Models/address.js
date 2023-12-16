const mongoose = require('mongoose');

const addressSchema = new mongoose.Schema({
  useremail:String,
  address:String,
  houseno:String,
  city: String,
  state: String,
  pincode:String
  
});

const Address = mongoose.model('Address', addressSchema);

module.exports = Address;