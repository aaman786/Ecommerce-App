const express = require("express");
const adminRouter = express.Router();
const admin = require("../middleware/admin");
const { Product } = require("../model/product");
const Order  = require("../model/order");

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

adminRouter.get("/admin/get-orders", admin, async (req, res) => {
  try {
    const orders = await Order.find({});
    res.json(orders);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// CHANGE ORDER STATUS
adminRouter.post("/admin/change-order-status", admin, async (req, res) => {
  try {
    const { id, status } = req.body;
    let order = await Order.findById(id);
    order.status = status;
    order = await order.save();
    res.json(order);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// ADMIN ANALYTICS
adminRouter.post("/admin/analytics", admin, async (req, res) => {
  try {
    const orders = await Order.find({});
    let totalEarning = 0;

    for (let i = 0; i < orders.length; i++) {
      for (let j = 0; j < orders[i].products.length; j++) {
        totalEarning +=
          orders[i].products[j].quantity * orders[i].products[j].price;
      }
    }

    //  CATEGORY WISE ORDER FETCHNING
    let mobileEarning = await fetchCategoryWiseProduct("Mobiles");
    let esssentialEarning = await fetchCategoryWiseProduct("Essential");
    let appliancsEarning = await fetchCategoryWiseProduct("Appliances");
    let bookEarning = await fetchCategoryWiseProduct("Book");

    let earning = {
      totalEarning,
      mobileEarning,
      esssentialEarning,
      appliancsEarning,
      bookEarning,
    };

    res.json(earning);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// FUNCTION FOR CATEGORY WISE FETCHING ORDERS
const fetchCategoryWiseProduct = async (category) => {
  let earning = 0;

  let categoryOrders = await Order.find({
    "products.product.category ": category,
  });

  for (let i = 0; i < categoryOrders.length; i++) {
    for (let j = 0; j < categoryOrders[i].products.length; j++) {
      earning +=
        categoryOrders[i].products[j].quantity *
        categoryOrders[i].products[j].price;
    }
  }
  return earning;
};
module.exports = adminRouter;
