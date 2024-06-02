const express = require("express");
const router = express.Router();
const db = require('../databases/postgre');
const crypto = require('crypto');

router.get("/", async (req, res, next) => {
    try {
        const result = await db.query('SELECT * FROM Products');
        res.json(result.rows);
      } catch (err) {
        console.error(err);
        res.status(500).send('Server error');
      }
});

router.post("/", async(req, res, next) => {
    const { brandId, name, description, categoryId, price, orderDetailId, unitWeight, unitsInStock, isAvailable, pictures } = req.body;
    const productId = crypto.randomUUID();

    if (!brandId || !name || !categoryId || !price) {
        return res.status(400).json({ error: "Missing required fields: brandId, name, categoryId, and price are required." });
    }
    
    const product = {
        ProductID: productId,
        BrandID: brandId,
        ProductName: name,
        ProductDescription: description,
        CategoryID: categoryId,
        UnitPrice: price,
        OrderDetailID: orderDetailId,
        UnitWeight: unitWeight,
        UnitsInStock: unitsInStock,
        isAvailable: isAvailable,
        Pictures: pictures,
        CreatedAt: new Date(),
        UpdatedAt: new Date()
    };  
    
    const query = `
        INSERT INTO Products (
            ProductID,
            BrandID,
            ProductName,
            ProductDescription,
            CategoryID,
            UnitPrice,
            OrderDetailID,
            UnitWeight,
            UnitsInStock,
            isAvailable,
            Pictures,
            CreatedAt,
            UpdatedAt
        ) VALUES (
            $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13
        ) RETURNING *;
    `;

    const values = [
        product.ProductID,
        product.BrandID,
        product.ProductName,
        product.ProductDescription,
        product.CategoryID,
        product.UnitPrice,
        product.OrderDetailID,
        product.UnitWeight,
        product.UnitsInStock,
        product.isAvailable,
        product.Pictures,
        product.CreatedAt,
        product.UpdatedAt
    ];

    try {
        const result = await db.query(query, values);
        res.json(result.rows[0]);
    } catch (err) {
        console.error(err);
        res.status(500).send('Server error');
    }
});

router.get("/:ProductID", async (req, res, next) => {
    const productId = req.params.ProductID;
    try {
        const result = await db.query('SELECT * FROM Products WHERE ProductId = $1', [productId]);

        if (result.rows.length === 0) {
            res.status(404).send('Product not found');
        } else {
            res.json(result.rows[0]);
        }
    } catch (err) {
        console.error(err);
        res.status(500).send('Server error');
    }
});

router.patch("/:ProductID", async (req, res, next) => {
    const productId = req.params.ProductID;
    const { name, price, description } = req.body;

    const fields = [];
    const values = [];

    const addField = (field, value) => {
        fields.push(`${field} = $${fields.length + 1}`);
        values.push(value);
    };

    if (name !== undefined) addField('name', name);
    if (price !== undefined) addField('price', price);
    if (description !== undefined) addField('description', description);

    if (fields.length === 0) {
        return res.status(400).send('No fields to update');
    }

    try {
        const query = `UPDATE productsId SET ${fields.join(', ')} WHERE id = $${fields.length + 1}`;
        values.push(productId); 

        const result = await db.query(query, values);

        if (result.rowCount === 0) {
            res.status(404).send('Product not found');
        } else {
            res.send('Product updated successfully');
        }
    } catch (err) {
        console.error(err);
        res.status(500).send('Server error');
    }
});

router.delete("/:ProductID", (req, res, next) => {
    res.status(200).json({
        message: 'Deleted'
    });
});

module.exports = router;
