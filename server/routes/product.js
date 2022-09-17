const express = require("express");
const productRouter = express.Router();
const Product = require("../model/product");

const auth = require("../middleware/auth");

// PRODUCT OF SPECIFIC CATEGORY
//  /api/product?category=Essential
productRouter.get("/api/products/", auth, async (req, res) => {
  try {
    // console.log(req.query.category);
    const product = await Product.find({ category: req.query.category });
    res.json(product);
  } catch (e) {
    res.statusCode(500).json({ error: e.message });
  }
});

// SEARCH PRODUCT AND GET THEM
productRouter.get("/api/products/search/:name", auth, async (req, res) => {
  try {
    
    const product = await Product.find({
      name: { $regex: req.params.name, $options: "i" },
    });
   
    res.json(product);
  } catch (e) {
    res.statusCode(500).json({ error: e.message });
  }
});

module.exports = productRouter;
