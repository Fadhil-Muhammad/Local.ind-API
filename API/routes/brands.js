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
        const brands = await knex("Brands").select("*");
        res.json(brands);
    } catch (error) {
        console.error(error);
        res.status(500).send("Server error");
    }
});

router.post("/", async (req, res) => {
    const { brandName, address,logo} = req.body;

    try {
        const brandId = generateUUID();
        await knex("Brands").insert({
            BrandId: brandId,
            Address: address,
            BrandName: brandName,
            Logo: logo,
            CreatedAt: new Date(),
            UpdatedAt: new Date(),
        });

        const newBrand = await knex("Brands")
            .where("BrandId", brandId)
            .first();
        res.json(newBrand);
    } catch (error) {
        console.error(error);
        res.status(500).send("Server error");
    }
});

router.get("/:BrandId", async (req, res) => {
    const brandId = req.params.BrandId;

    try {
        const brand = await knex("Brands")
            .where("BrandId", brandId)
            .first();
        if (!brand) {
            return res.status(404).send("Brand not found");
        }
        res.json(brand);
    } catch (error) {
        console.error(error);
        res.status(500).send("Server error");
    }
});

router.patch("/:BrandId", async (req, res) => {
    const brandId = req.params.BrandId;
    const { brandName, logo, address} = req.body;

    const fieldsToUpdate = {};
    if (brandName) fieldsToUpdate.BrandName = brandName;
    if (logo) fieldsToUpdate.Logo = logo;
    if (address) fieldsToUpdate.Address = address;
    fieldsToUpdate.UpdatedAt = new Date();

    try {
        const updatedCount = await knex("Brands")
            .where("BrandId", brandId)
            .update(fieldsToUpdate);
        if (updatedCount === 0) {
            return res.status(404).send("Brand not found");
        }
        const updatedBrand = await knex("Brands")
            .where("BrandId", brandId)
            .first();
        res.json(updatedBrand);
    } catch (error) {
        console.error(error);
        res.status(500).send("Server error");
    }
});

// Delete address by AddressId
router.delete("/:BrandId", async (req, res) => {
    const brandId = req.params.BrandId;

    try {
        const deletedCount = await knex("Brands")
            .where("BrandId", brandId)
            .del();
        if (deletedCount === 0) {
            return res.status(404).send("Brand not found");
        }
        res.status(200).send("Brand deleted successfully");
    } catch (error) {
        console.error(error);
        res.status(500).send("Server error");
    }
});

module.exports = router;
