// import from packages
const express = require("express");
const mongoose = require("mongoose");

// other files import
const authRouter = require("./routes/auth");
const Product = require("./model/product");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");

// INIT
const PORT = 3000;
const app = express();
const DB =
  "mongodb+srv://aaman:satvilkar@cluster0.qa9xylk.mongodb.net/?retryWrites=true&w=majority";

// middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);

// connections
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection to Mongoose Sucessful");
  })
  .catch((e) =>
    console.log(`The error during connecting to Mongoose is: ${e}`)
  );

// Creating API
app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});

// // making an path of API
// // http://<youripaddress>/hello-world
// app.get("/hello-world", (req, res) => {
//   res.send({ hi: "Hello World" });
// });
