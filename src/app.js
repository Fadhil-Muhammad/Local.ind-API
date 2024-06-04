const express = require('express');
const app = express();
const morgan = require('morgan');
const bodyParser = require('body-parser');

const brandsRoutes = require('../API/routes/brands');
const categoriesRoutes = require('../API/routes/categories')
const productsRoutes = require('../API/routes/products')
const loginRoutes = require('../API/routes/login')

app.use(morgan('dev'));
app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());

app.use((req, res, next)=>{
    res.header('Acces-Control-Allow-Origin', '*');
    res.header('Acces-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');
    if (req.method === 'OPTIONS'){
        res.header('Acces-Control-Allow-Method', 'PUT, POST, PATCH, DELETE, GET');
        return res.status(200).json({});
    }
    next();
});

app.use('/brands',brandsRoutes);
app.use('/categories',categoriesRoutes);
app.use('/products',productsRoutes);
app.use('/login',loginRoutes);

app.use((req,res,next)=>{
    const error = new Error('Not Found');
    error.status= 404 ;
    next(error);
});

app.use((error,req,res,next)=>{
    res.status(error.status || 500);
    res.json({
        error: {
            message: error.message
        }
    });
});

module.exports = app;