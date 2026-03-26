const express = require("express");

const productRouter = express.Router();
const auth = require("../middlewares/auth");
const Product = require("../models/product");

// /api/products?category=Essentials = req.query.category
// /api/products?makanan=Bakso = req.query.makanan
productRouter.get("/api/products", auth, async (req, res) => {
  try {
    console.log(req.query.category);

    const products = await Product.find({ category: req.query.category });
    res.json(products);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// /api/products/search/:category = req.params.category
// /api/products/search/:makanan = req.params.makanan
productRouter.get("/api/products/search/:name", auth, async (req, res) => {
  try {
    console.log(req.params.name);

    const products = await Product.find({
      name: { $regex: req.params.name, $options: "i" },
    });
    res.json(products);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = productRouter;
