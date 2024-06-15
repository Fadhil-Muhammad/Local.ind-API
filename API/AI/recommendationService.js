const natural = require('natural');
const tf = require('@tensorflow/tfjs');
const knexConfig =
    require("../databases/knex")[process.env.NODE_ENV || "development"];
const knex = require("knex")(knexConfig);

// Fetch data from the database
async function fetchDataFromDB() {
    try {
        return await knex.select('ProductId', 'ProductName', 'CategoryId', 'BrandId').from('Products');
    } catch (error) {
        console.error("Error fetching data from DB:", error);
        throw error;
    }
}

// Preprocess data
async function preprocessData(data) {
    const df = data.map(row => ({
        ProductId: row.ProductId,
        combined_features: (row.ProductName + ' ' + row.CategoryId + ' ' + row.BrandId).toLowerCase()
    }));

    const vectorizer = new natural.TfIdf();
    df.forEach(item => vectorizer.addDocument(item.combined_features));

    const tfidfMatrix = df.map(item => {
        const vector = [];
        vectorizer.tfidfs(item.combined_features, (i, measure) => vector.push(measure));
        return vector;
    });

    console.log("Preprocessed Data:", df);  // Debugging log
    return { vectorizer, tfidfMatrix, df };
}

// Get recommendations
function getRecommendations(query, vectorizer, tfidfMatrix, df, topN = 20) {
    query = query.toLowerCase();
    const queryVector = [];
    vectorizer.tfidfs(query, (i, measure) => queryVector.push(measure));

    const cosineSimQuery = tfidfMatrix.map(vector => {
        const dotProduct = vector.reduce((sum, val, idx) => sum + val * queryVector[idx], 0);
        const normA = Math.sqrt(vector.reduce((sum, val) => sum + val * val, 0));
        const normB = Math.sqrt(queryVector.reduce((sum, val) => sum + val * val, 0));
        return dotProduct / (normA * normB);
    });

    console.log("Cosine Similarity Query:", cosineSimQuery);  // Debugging log

    const simScores = cosineSimQuery.map((score, index) => ({ index, score }));
    simScores.sort((a, b) => b.score - a.score);

    const recommendations = simScores.slice(0, topN).map(simScore => ({
        ...df[simScore.index],
        similarity: simScore.score
    }));

    const idItems = recommendations.map(rec => rec.ProductId);
    return idItems;
}

async function getProductDetailsByIds(ids) {
    try {
        const products = await knex.select('*').from('Products').whereIn('ProductId', ids);
        return products;
    } catch (error) {
        console.error("Error fetching product details:", error);
        throw error;
    }
}

module.exports = {
    fetchDataFromDB,
    preprocessData,
    getRecommendations,
    getProductDetailsByIds
};
