const mongoose = require("mongoose");

const imageSchema = mongoose.Schema({
  imageUrl: {
    type: String,
    required: true,
  },
  publicId: {
    type: String,
    required: true,
  },
});

module.exports = imageSchema;
