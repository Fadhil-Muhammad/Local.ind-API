const express = require("express");
const router = express.Router();
const knexConfig =
    require("../databases/knex")[process.env.NODE_ENV || "development"];
const knex = require("knex")(knexConfig);
const authMiddleware = require("../auth/middleware/authMiddleware");
const crypto = require("crypto");

const generateUUID = () => {
    return crypto.randomUUID();
};

const addDays = (date, days) => {
    const result = new Date(date);
    result.setDate(result.getDate() + days);
    return result;
};

router.post("/", authMiddleware, async (req, res) => {
    try {
        const {
            freight,
            paymentId,
            orderStatusId,
            shipperId
        } = req.body;
        const customerId = req.customerId;

        const allCartId = await knex("Cart").where("CustomerId",customerId).select("Cart.CartId");
        const cartIds = allCartId.map(row => row.CartId);

        const product = await knex("Products")
        .select("ProductId", "UnitPrice")
        .where("ProductId", (knex) => {
            knex.select("ProductId")
                 .from("Cart")
                 .where("CartId", cartIds[0]);
        })
        .first();

    if (!product) {
        return res.status(404).json({ error: "Product not found in the cart" });
    }

    // Fetch the quantity from the cart table
    const cartItem = await knex("Cart")
        .select("Count")
        .where("CartId", cartIds[0])
        .first();

    if (!cartItem) {
        return res.status(404).json({ error: "Cart item not found" });
    }

    // const DefaultOrderStatus = await knex("OrderStatus").where({"StatusName":"Processing"}).select("OrderStatus.OrderStatusId")

        const order = {
            OrderId: generateUUID(),
            CustomerId: customerId,
            PaymentId: paymentId,
            OrderStatusId: orderStatusId || "797708fc-0203-48d5-9d55-092e0a0c0c17",
            ShipperId: shipperId,
            Freight: freight,
            OrderDate: new Date(),
            ShipDate: addDays(new Date(), 1),
            ShipLimitDate: addDays(new Date(), 3),
            PaymentDate: new Date(),
            CreatedAt: new Date(),
            UpdatedAt: new Date(),
            CartId: cartIds[0],
            ProductId: product.ProductId,
            Price: product.UnitPrice,
            Quantity: cartItem.Count,
        };

        await knex("Orders").insert(order);
        
        await knex("Cart").where("CartId", cartIds[0]).update({ IsActive: false });
        res.status(201).json({ message: "Kindly wait until the order is arive", order });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Internal server error" });
    }
});

router.get("/", async (req, res) => {
    try {
        const order = await knex("Orders")
            .select(
                "Orders.*",
                "Customers.FullName",
                "Payments.PaymentType",
                "OrderStatus.StatusName",
                "Shippers.CompanyName",
                "Products.ProductName"
            )
            .leftJoin("Customers", "Orders.CustomerId", "Customers.CustomerId")
            .leftJoin("Payments", "Orders.PaymentId", "Payments.PaymentId")
            .leftJoin("OrderStatus", "Orders.OrderStatusId", "OrderStatus.OrderStatusId")
            .leftJoin("Shippers","Orders.ShipperId","Shippers.ShipperId")
            .leftJoin("Products","Orders.ProductId","Products.ProductId");
        res.json(order);
    } catch (error) {   
        console.error(error);
        res.status(500).send("Server error");
    }
});

router.get("/process", authMiddleware, async (req, res) => {
    const customerId = req.customerId;

    try {
        const order = await knex("Orders")
            .select(
                "Orders.*",
                "Customers.FullName",
                "Payments.PaymentType",
                "OrderStatus.StatusName",
                "Shippers.CompanyName",
                "Products.ProductName"
            )
            .leftJoin("Customers", "Orders.CustomerId", "Customers.CustomerId")
            .leftJoin("Payments", "Orders.PaymentId", "Payments.PaymentId")
            .leftJoin("OrderStatus", "Orders.OrderStatusId", "OrderStatus.OrderStatusId")
            .leftJoin("Shippers", "Orders.ShipperId", "Shippers.ShipperId")
            .leftJoin("Products","Orders.ProductId","Products.ProductId")
            .where({ 
                "Orders.CustomerId": customerId,
             });
        if (order.length === 0) {
            return res.status(404).send("Cart not found");
        }
        res.json(order);
    } catch (error) {
        console.error(error);
        res.status(500).send("Server error");
    }
});

router.get("/finished", authMiddleware, async (req, res) => {
    const customerId = req.customerId;

    try {
        const order = await knex("Orders")
            .select(
                "Orders.*",
                "Customers.FullName",
                "Payments.PaymentType",
                "OrderStatus.StatusName",
                "Shippers.CompanyName",
                "Products.ProductName"
            )
            .leftJoin("Customers", "Orders.CustomerId", "Customers.CustomerId")
            .leftJoin("Payments", "Orders.PaymentId", "Payments.PaymentId")
            .leftJoin("OrderStatus", "Orders.OrderStatusId", "OrderStatus.OrderStatusId")
            .leftJoin("Shippers", "Orders.ShipperId", "Shippers.ShipperId")
            .leftJoin("Products","Orders.ProductId","Products.ProductId")
            .where({ 
                "Orders.CustomerId": customerId,
                "OrderStatus.StatusName":"Finished"
             });
        if (order.length === 0) {
            return res.status(404).send("No finished orders found for this customer");
        }
        res.json(order);
    } catch (error) {
        console.error(error);
        res.status(500).send("Server error");
    }
});

module.exports = router;
