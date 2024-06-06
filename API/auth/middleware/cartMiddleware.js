const { verifyToken } = require('./auth.utils');

const cartMiddleware = async (req, res, next) => {
  const token = req.headers.authorization;

  if (!token) {
    return res.status(401).json({ error: 'Authorization token missing' });
  }

  const decoded = verifyToken(token);

  if (!decoded) {
    return res.status(401).json({ error: 'Invalid authorization token' });
  }

  const customerId = decoded.customerId;
  req.customerId = customerId;

  try {
    // Check if the user has an existing cart
    const cart = await knex('Carts')
      .select('*')
      .where({ CustomerId: customerId })
      .first();

    // Attach the cart data to the request object
    req.cart = cart || null;
    next();
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal server error' });
  }
};

module.exports = cartMiddleware;