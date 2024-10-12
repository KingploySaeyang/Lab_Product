require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('./models/user'); // โมเดลผู้ใช้ใน MongoDB

const app = express();
app.use(express.json());

// เชื่อมต่อกับ MongoDB
mongoose.connect(process.env.MONGO_DB_URI, {
}).then(() => {
    console.log('MongoDB connected');
}).catch((err) => {
    console.error('Failed to connect to MongoDB:', err);
});

// Config Route
const productRoutes = require('./routes/product');
app.use('/api/product', productRoutes);

const authRoutes = require('./routes/auth');
app.use('/api/auth', authRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
