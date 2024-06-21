const swaggerAutogen = require('swagger-autogen')();

const doc = {
    info: {
        title: 'Lokal.ind API',
        description: 'Documentation of Lokal.ind API. Full repository provided bellow',
        contact:{
            name: "C241-PS127 Cloud Computing team",
            url: 'https://github.com/C241-PS127/Cloud-Computing-API'
        } 
    },
    host: 'lokal-ind.et.r.appspot.com',
    schemes: ['https'],
    tags: [
        {
            name: 'Brands',
            description: 'API endpoints related to brands',
        },
        {
            name: 'Categories',
            description: 'API endpoints related to categories',
        },
        {
            name: 'Products',
            description: 'API endpoints related to products',
        },
        {
            name: 'Shippers',
            description: 'API endpoints related to shippers',
        },
        {
            name: 'Payments',
            description: 'API endpoints related to payments',
        },
        {
            name: 'Order Status',
            description: 'API endpoints related to order status',
        },
        {
            name: 'Auth',
            description: 'API endpoints related to authentication',
        },
        {
            name: 'Cart',
            description: 'API endpoints related to cart',
        },
        {
            name: 'Wishlist',
            description: 'API endpoints related to wishlist',
        },
        {
            name: 'Orders',
            description: 'API endpoints related to orders',
        },
        {
            name: 'Recommendation',
            description: 'API endpoints related to recommendations',
        },
    ],
};

const outputFile = './swagger-output.json';
const endpointsFiles = ['../src/app.js'];

swaggerAutogen(outputFile, endpointsFiles, doc).then(() => {
    console.log("Swagger documentation generated");
});