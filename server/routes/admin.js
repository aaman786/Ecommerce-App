const express = require("express");
const adminRouter = express.Router();
const admin = require("../middleware/admin");
const Product = require("../model/product");

// ADD PRODUCT
adminRouter.post("/admin/add-product", admin, async (req, res) => {
  try {
    const { name, description, images, quantity, price, category } = req.body;
    let product = new Product({
      name,
      description,
      images,
      quantity,
      price,
      category,
    });
    product = await product.save();
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// GET ALL PRODUCT
adminRouter.get("/admin/get-products", admin, async (req, res) => {
  try {
    const product = await Product.find({});
    res.json(product);
  } catch (err) {
    res.status(500).json({ eror: err.message });
  }
});

// DELETE THE PRODUCT
adminRouter.post("/admin/delete-product", admin, async (req, res) => {
  try {
    const { id } = req.body;
    let product = await Product.findByIdAndDelete(id);
    // res.send("All good, Deletion of product successfull");
    res.json(product);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = adminRouter;
