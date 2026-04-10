const express = require("express");
const admin = require("../middlewares/admin");
const { Product } = require("../models/product");
const Order = require("../models/order");

const adminRoute = express.Router();

adminRoute.post("/admin/add-product", admin, async (req, res) => {
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
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

adminRoute.get("/admin/get-products", admin, async (req, res) => {
  try {
    const products = await Product.find({});
    res.json(products);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

adminRoute.post("/admin/delete-product", admin, async (req, res) => {
  try {
    const { id } = req.body;

    let product = await Product.findByIdAndDelete(id);

    res.json(product);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

adminRoute.get("/admin/get-orders", admin, async (req, res) => {
  try {
    const orders = await Order.find({});

    res.json(orders);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

adminRoute.post("/admin/change-order-status", admin, async (req, res) => {
  try {
    const { id, status } = req.body;

    let order = await Order.findById(id);

    order.status = status;

    order = await order.save();

    res.json(order);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

adminRoute.get("/admin/analytics", admin, async (req, res) => {
  try {
    const orders = await Order.find({});

    let totalEarnings = 0;

    for (let i = 0; i < orders.length; i++) {
      for (let j = 0; j < orders[i].products.length; j++) {
        totalEarnings +=
          orders[i].products[j].quantity * orders[i].products[j].product.price;
      }
    }

    let mobileEarnings = await fetchCategoryWiseProducts("Mobiles");
    let essentialsEarnings = await fetchCategoryWiseProducts("Essentials");
    let appliancesEarnings = await fetchCategoryWiseProducts("Appliances");
    let booksEarnings = await fetchCategoryWiseProducts("Books");
    let fashionEarnings = await fetchCategoryWiseProducts("Fashion");

    let earnings = {
      totalEarnings,
      mobileEarnings,
      essentialsEarnings,
      appliancesEarnings,
      booksEarnings,
      fashionEarnings,
    };

    res.json(earnings);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

async function fetchCategoryWiseProducts(category) {
  let earnings = 0;
  let categoryOrders = await Order.find({
    "products.product.category": category,
  });

  for (let i = 0; i < categoryOrders.length; i++) {
    for (let j = 0; j < categoryOrders[i].products.length; j++) {
      if (categoryOrders[i].products[j].product.category === category) {
        earnings +=
          categoryOrders[i].products[j].quantity *
          categoryOrders[i].products[j].product.price;
      }
    }
  }

  return earnings;
}

module.exports = adminRoute;
