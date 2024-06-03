const express = require("express");
const router = express.Router();
const db = require('../databases/postgre');
const crypto = require('crypto');

router.get("/", async (req, res, next) => {
    try {
        const result = await db.query('SELECT * FROM Addresses');
        res.json(result.rows);
      } catch (err) {
        console.error(err);
        res.status(500).send('Server error');
      }
});

router.post("/", async(req, res, next) => {
    const { province, city, subdistrict, address, postalcode} = req.body;
    const addressId = crypto.randomUUID();

    if (!province || !city || !subdistrict || !address || !postalcode) {
        return res.status(400).json({ error: "Missing required fields: province, city, subdistrict, address, postalcode" });
    }
    
    const addresses = {
        AddressId: addressId,
        Province: province,
        City: city,
        Subdistrict: subdistrict,
        Address: address,
        Postalcode: postalcode,
        CreatedAt: new Date(),
        UpdatedAt: new Date()
    };  
    
    const query = `
        INSERT INTO Addresses (
            AddressId,
            Province,
            City,
            Subdistrict,
            Address,
            Postalcode,
            CreatedAt,
            UpdatedAt
        ) VALUES (
            $1, $2, $3, $4, $5, $6, $7, $8
        ) RETURNING *;
    `;

    const values = [
        addresses.AddressId,
        addresses.Province,
        addresses.City,
        addresses.Subdistrict,
        addresses.Address,
        addresses.Postalcode,
        addresses.CreatedAt,
        addresses.UpdatedAt
    ];

    try {
        const result = await db.query(query, values);
        res.json(result.rows[0]);
    } catch (err) {
        console.error(err);
        res.status(500).send('Server error');
    }
});

router.get("/:AddressId", async (req, res, next) => {
    const addressId = req.params.AddressId;
    try {
        const result = await db.query('SELECT * FROM Addresses WHERE AddressId = $1', [addressId]);

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

router.patch("/:AddressId", async (req, res, next) => {
    const addressId = req.params.AddressId;
    const { province, city, subdistrict, address, postalcode } = req.body;

    const fieldsToUpdate = [];
    const values = [];
    let query = 'UPDATE Addresses SET ';

    if (province) {
        fieldsToUpdate.push('Province = $' + (fieldsToUpdate.length + 1));
        values.push(province);
    }
    if (city) {
        fieldsToUpdate.push('City = $' + (fieldsToUpdate.length + 1));
        values.push(city);
    }
    if (subdistrict) {
        fieldsToUpdate.push('Subdistrict = $' + (fieldsToUpdate.length + 1));
        values.push(subdistrict);
    }
    if (address) {
        fieldsToUpdate.push('Address = $' + (fieldsToUpdate.length + 1));
        values.push(address);
    }
    if (postalcode) {
        fieldsToUpdate.push('Postalcode = $' + (fieldsToUpdate.length + 1));
        values.push(postalcode);
    }

    if (fieldsToUpdate.length === 0) {
        return res.status(400).json({ error: "No fields to update" });
    }

    fieldsToUpdate.push('UpdatedAt = $' + (fieldsToUpdate.length + 1));
    values.push(new Date());

    query += fieldsToUpdate.join(', ') + ' WHERE AddressId = $' + (fieldsToUpdate.length + 1) + ' RETURNING *;';
    values.push(addressId);

    try {
        const result = await db.query(query, values);

        if (result.rows.length === 0) {
            return res.status(404).send('Address not found');
        }

        res.json(result.rows[0]);
    } catch (err) {
        console.error(err);
        res.status(500).send('Server error');
    }
});

router.delete("/:AddressId", async(req, res, next) => {
    const addressId = req.params.AddressId;
    try {
        const result = await db.query('DELETE FROM Addresses WHERE AddressId = $1', [addressId]);

        if (result.rowCount === 0) {
            res.status(404).send('Address not found');
        } else {
            res.status(200).send('Address deleted successfully')
        }
    } catch (err) {
        console.error(err);
        res.status(500).send('Server error');
    }
});

module.exports = router;
