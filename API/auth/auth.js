const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const secret = 's3cr3tk3y'; 
const knexConfig =
    require("../databases/knex")[process.env.NODE_ENV || "development"];
const knex = require("knex")(knexConfig);

function generateToken(customerId) {
  return jwt.sign({ customerId }, secret, { expiresIn: '1h' });
}

async function authenticateUser(email, password) {
  const customer = customers.find((c) => c.Email === email);

  if (!customer) {
    return { error: 'Invalid email or password' };
  }

  const isPasswordValid = await bcrypt.compare(password, customer.Password);

  if (!isPasswordValid) {
    return { error: 'Invalid email or password' };
  }

  const token = generateToken(customer.CustomerId);
  return { token };
}

function verifyToken(token) {
  try {
    const decoded = jwt.verify(token, secret);
    return decoded;
  } catch (err) {
    return { error: 'Invalid token' };
  }
}

module.exports = {
  authenticateUser,
  verifyToken,
};