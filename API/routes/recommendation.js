const express = require("express");
const router = express.Router();
const recommendationService = require('../AI/recommendationService');

router.get('/', async (req, res) => {
    const query = req.query.query;
    if (!query) {
        return res.status(400).json({ error: "Query parameter is required" });
    }

    try {
        const data = await recommendationService.fetchDataFromDB();
        const { vectorizer, tfidfMatrix, df } = await recommendationService.preprocessData(data);
        const recommendedIds = recommendationService.getRecommendations(query, vectorizer, tfidfMatrix, df);
        const productDetails = await recommendationService.getProductDetailsByIds(recommendedIds);
        res.json({product:productDetails});
    } catch (error) {
        res.status(500).json({ error: "An error occurred while processing your request" });
    }
});

module.exports = router;
