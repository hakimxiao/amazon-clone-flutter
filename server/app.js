const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./src/routes/auth");
const adminRoute = require("./src/routes/admin");
require("dotenv").config();

const app = express();
const PORT = process.env.PORT || 3000;
const MONGODB_URL = process.env.MONGODB_URL;

app.use(express.json());
app.use(authRouter);
app.use(adminRoute);

mongoose
  .connect(MONGODB_URL)
  .then(() => {
    console.log("Connected to MongoDB ♻️");
  })
  .catch((err) => {
    console.log(err);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log("Server is running 🚀 on port", PORT);
});
