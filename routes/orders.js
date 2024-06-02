const express = require("express");
const router = express.Router();

router.get("/", (req, res, next) => {
    res.status(200).json({
        message: "Order were fetched",
    });
});

router.post("/", (req, res, next) => {
    const order = {
        ProductID : req.body.ProductID,
        quantity : req.body.quantity
    }
    res.status(201).json({
        message: "Order created",
        createdOrder: order
    });
});

router.get("/:OrderID", (req, res, next) => {
    res.status(200).json({
        message: "Order details",
        OrderID: req.params.OrderID
    });
});

router.delete("/:OrderID", (req, res, next) => {
    res.status(200).json({
        message: "Order deleted",
        OrderID: req.params.OrderID
    });
});

module.exports = router;