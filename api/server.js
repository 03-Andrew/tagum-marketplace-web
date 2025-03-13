require('dotenv').config();

const express = require('express');
const cors = require("cors");
const bodyParser = require('body-parser');
const app = express();
const port = process.env.PORT || 3000;

const defRouter = require('./routes/index');
const authRoutes = require('./routes/authRoutes');
const brandRoutes = require('./routes/brandRoutes');
const employeeUserRoutes = require('./routes/employeeUserRoutes');
const productRoutes = require('./routes/productRoutes');
const customerRoutes = require('./routes/customerRoutes');
const saleRoutes = require('./routes/saleRoutes');
const remarkRoutes = require('./routes/remarkRoutes');
const supplyRoutes = require('./routes/supplyRoutes');
const stockOutSupplyRoutes = require('./routes/stockOutSupplyRoutes');
const productVariantRoutes = require('./routes/productVariantRoutes');
const saleDetailRoutes = require('./routes/saleDetailRoutes');
const supplierRoutes = require('./routes/supplierRoutes');
const supplyDetailsRoutes = require('./routes/supplyDetailsRoutes');
const analyticsRoutes = require('./routes/analyticsRoutes');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors({
  origin: ["http://localhost:1420", "https://tagum-marketplace-web2-z7qf.vercel.app"],
  methods: "GET,POST,PUT,DELETE,OPTIONS",
  allowedHeaders: "Content-Type,Authorization",
  credentials: true
}));

app.use('/', defRouter);
app.use('/api/supplier', supplierRoutes);
app.use('/api/auth', authRoutes);
app.use('/api/brand', brandRoutes);
app.use('/api/employee', employeeUserRoutes);
app.use('/api/product', productRoutes);
app.use('/api/customer', customerRoutes);
app.use('/api/sale', saleRoutes);
app.use('/api/remark', remarkRoutes);
app.use('/api/supply', supplyRoutes);
app.use('/api/stockOut', stockOutSupplyRoutes);
app.use('/api/productVariant', productVariantRoutes);
app.use('/api/saleDetail', saleDetailRoutes);
app.use('/api/supplyDetail', supplyDetailsRoutes);
app.use('/api/analytics', analyticsRoutes);
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});