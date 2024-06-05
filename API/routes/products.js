const express = require("express");
const router = express.Router();
const knexConfig =
    require("../databases/knex")[process.env.NODE_ENV || "development"];
const knex = require("knex")(knexConfig);
const crypto = require("crypto");

const generateUUID = () => {
    return crypto.randomUUID();
};

router.get("/", async (req, res) => {
    try {
        const products = await knex("Products")
            .select(
                "Products.*",
                "Brands.BrandName",
                "Categories.CategoryName"
            )
            .leftJoin("Brands", "Products.BrandId", "Brands.BrandId")       
            .leftJoin("Categories", "Products.CategoryId", "Categories.CategoryId");
        res.json(products);
    } catch (error) {
        console.error(error);
        res.status(500).send("Server error");
    }
});

router.post("/", async (req, res) => {
    const { productName, productDescription, brandId, categoryId, unitPrice, unitSize, unitInStock, isAvailable, pictures} = req.body;

    try {
        const productId = generateUUID();
        await knex("Products").insert({
            ProductId: productId,
            ProductName: productName,
            ProductDescription: productDescription,
            BrandId: brandId,
            CategoryId:categoryId,
            UnitPrice:unitPrice,
            UnitSize: unitSize,
            UnitInStock: unitInStock,
            isAvailable: isAvailable,
            Pictures: pictures,
            CreatedAt: new Date(),
            UpdatedAt: new Date(),
        });

        const newProduct = await knex("Products")
            .select(
                "Products.*",
                "Brands.BrandName",
                "Categories.CategoryName",
            )
            .where("Products.ProductId", productId)
            .leftJoin("Brands", "Products.BrandId", "Brands.BrandId")
            .leftJoin("Categories", "Products.CategoryId", "Categories.CategoryId")
            .first();
        res.json(newProduct);
    } catch (error) {
        console.error(error);
        res.status(500).send("Server error");
    }
});
router.patch("/:ProductId", async (req, res) => {
    const productId = req.params.ProductId;
    const { productName, productDescription, categoryId, unitPrice, unitSize, unitInStock, isAvailable, pictures} = req.body;

    const fieldsToUpdate = {};
    if (productName) fieldsToUpdate.ProductName = productName;
    if (productDescription) fieldsToUpdate.ProductDescription = productDescription;
    if (categoryId) fieldsToUpdate.CategoryId = categoryId;
    if (unitPrice) fieldsToUpdate.UnitPrice = unitPrice;
    if (unitSize) fieldsToUpdate.UnitSize = unitSize;
    if (unitInStock) fieldsToUpdate.UnitInStock = unitInStock;
    if (isAvailable) fieldsToUpdate.isAvailable = isAvailable;
    if (pictures) fieldsToUpdate.Pictures = pictures;

    try {
        const updatedCount = await knex("Products")
            .where("ProductId", productId)
            .update(fieldsToUpdate);
        if (updatedCount === 0) {
            return res.status(404).send("product not found");
        }
        const updatedshipper = await knex("Products")
            .where("ProductId", productId)
            .first();
        res.json(updatedshipper);
    } catch (error) {
        console.error(error);
        res.status(500).send("Server error");
    }
});

router.delete("/:ProductId", async (req, res) => {
    const productId = req.params.ProductId;

    try {
        const deletedCount = await knex("Products")
            .where("ProductId", productId)
            .del();
        if (deletedCount === 0) {
            return res.status(404).send("Product not found");
        }
        res.status(200).send("Product deleted successfully");
    } catch (error) {
        console.error(error);
        res.status(500).send("Server error");
    }
});

module.exports = router;
