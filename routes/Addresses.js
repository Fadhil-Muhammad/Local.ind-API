const express = require("express");
const router = express.Router();
const knexConfig = require('../databases/knex')[process.env.NODE_ENV || 'development']; 
const knex = require('knex')(knexConfig);
const crypto = require('crypto');

const generateUUID = () => {
  return crypto.randomUUID();
};

router.get("/", async (req, res) => {
  try {
    const addresses = await knex('Addresses').select('*');
    res.json(addresses);
  } catch (error) {
    console.error(error);
    res.status(500).send('Server error');
  }
});

router.post("/", async (req, res) => {
  const { province, city, subdistrict, address, postalcode } = req.body;
  
  try {
    const addressId = generateUUID();
    await knex('Addresses').insert({
      AddressId: addressId,
      Province: province,
      City: city,
      SubDistrict: subdistrict,
      Address: address,
      PostalCode: postalcode,
      CreatedAt: new Date(),
      UpdatedAt: new Date()
    });
    
    const newAddress = await knex('Addresses').where('AddressId', addressId).first();
    res.json(newAddress);
  } catch (error) {
    console.error(error);
    res.status(500).send('Server error');
  }
});

router.get("/:AddressId", async (req, res) => {
  const addressId = req.params.AddressId;
  
  try {
    const address = await knex('Addresses').where('AddressId', addressId).first();
    if (!address) {
      return res.status(404).send('Address not found');
    }
    res.json(address);
  } catch (error) {
    console.error(error);
    res.status(500).send('Server error');
  }
});

router.patch("/:AddressId", async (req, res) => {
  const addressId = req.params.AddressId;
  const { province, city, subdistrict, address, postalcode } = req.body;

  const fieldsToUpdate = {};
  if (province) fieldsToUpdate.Province = province;
  if (city) fieldsToUpdate.City = city;
  if (subdistrict) fieldsToUpdate.SubDistrict = subdistrict;
  if (address) fieldsToUpdate.Address = address;
  if (postalcode) fieldsToUpdate.PostalCode = postalcode;
  fieldsToUpdate.UpdatedAt = new Date();

  try {
    const updatedCount = await knex('Addresses').where('AddressId', addressId).update(fieldsToUpdate);
    if (updatedCount === 0) {
      return res.status(404).send('Address not found');
    }
    const updatedAddress = await knex('Addresses').where('AddressId', addressId).first();
    res.json(updatedAddress);
  } catch (error) {
    console.error(error);
    res.status(500).send('Server error');
  }
});

// Delete address by AddressId
router.delete("/:AddressId", async (req, res) => {
  const addressId = req.params.AddressId;
  
  try {
    const deletedCount = await knex('Addresses').where('AddressId', addressId).del();
    if (deletedCount === 0) {
      return res.status(404).send('Address not found');
    }
    res.status(200).send('Address deleted successfully');
  } catch (error) {
    console.error(error);
    res.status(500).send('Server error');
  }
});

module.exports = router;
