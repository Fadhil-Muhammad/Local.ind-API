const express = require("express");
const router = express.Router();
const knexConfig = require("../databases/knex")[process.env.NODE_ENV || "development"];
const knex = require("knex")(knexConfig);
const auth = require('../auth/auth'); // Import the auth module
const { authenticateUser, verifyToken } = auth; // Destructure the functions


router.post('/auth', async (req, res) => {
    try{
        const { email, password } = req.body;
        const customerData = await authenticateUser(email, password);
  
        if (customerData.error) {
        return res.status(401).json({ error: customerData.error });
    }
  
    res.json(customerData);
    }
    
});

router.get('/protected', (req, res) => {
  const token = req.headers.authorization;

  if (!token) {
    return res.status(401).json({ error: 'No token provided' });
  }

  const decoded = verifyToken(token);

  if (decoded.error) {
    return res.status(403).json({ error: decoded.error });
  }

  res.json({ message: 'Protected data' });
});

router.post('/register', async (req, res) => {
    const { picture, fullName, address, phone, email, password } = req.body;
  
    try {
      // Hash the password
      const hashedPassword = await bcrypt.hash(password, 10);
  
      // Insert the new customer into the database
      const [customerId] = await knex('Customers').insert({
        Picture: picture,
        FullName: fullName,
        Address: address,
        Phone: phone,
        Email: email,
        Password: hashedPassword,
      });
  
      // Generate a JWT token for the new customer
      const token = generateToken(customerId);
  
      // Return the customer data and token
      const customerData = {
        CustomerId: customerId,
        Picture: picture,
        FullName: fullName,
        Address: address,
        Phone: phone,
        Email: email,
        token,
      };
  
      res.status(201).json(customerData);
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'An error occurred while creating the customer' });
    }
  });