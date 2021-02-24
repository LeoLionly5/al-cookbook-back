const express = require('express');
const mysql = require('mysql');
const Router = express.Router();
const dbConnection = require('../middlewares/mysql');
const apiUrl = '/api' ;
const fs = require('fs');
const bitmap = fs.readFileSync("public/images/test.png");
const outputfile = "output.png";

// upload recipe
const uploadRecipe = `INSERT INTO recipe (recipe_id, recipe_name) VALUES(?,?)`
Router.post(apiUrl+'/uploadRecipe', function(req, res, next) {
    dbConnection.query(uploadRecipe, [0,'test'], (err, result) => {
        if(err){
          console.log('[SELECT ERROR] - ',err.message);
          return;
        }
        res.status(200).json(result);
    });
});

// get all recipes
const getAllRecipes = `SELECT * FROM recipe WHERE 1=1`;
Router.get(apiUrl+'/getAllRecipes', (req, res) => {
    dbConnection.query(getAllRecipes, (err, result) => {
        if(err){
          console.log('[SELECT ERROR] - ',err.message);
          return;
        }
        res.status(200).json(result);
    });
});

// result example:
// [{
//     "recipe_id": 1,
//     "recipe_name": "Stir-fried tomato with egg",
//     "recipe_description": null,
//     "prep_time": 5,
//     "cook_time": 10,
//     "recipe_subtitle": null,
//     "main_image": null,
//     "sub_image": null,
//     "calorie_per_100g": 74,
//     "create_time": null,
//     "update_time": null
// }]

// get recipe by recipe_id
const getRecipeById = `SELECT * FROM recipe WHERE recipe_id = ?`;
Router.get(apiUrl+'/getRecipeById', (req, res) => {
    // console.log(JSON.stringify(req.body))
    dbConnection.query(getRecipeById, [req.body.recipe_id], (err, result) => {
        if(err){
          console.log('[SELECT ERROR] - ',err.message);
          return;
        }
        res.status(200).json(result);
    });
});

// get recipe by recipe_name, using "LIKE"
const getRecipesByName = `SELECT * FROM recipe WHERE recipe_name LIKE "%`;
Router.get(apiUrl+'/getRecipesByName', (req, res) => {
    console.log(JSON.stringify(req.body))
    dbConnection.query(getRecipesByName + req.body.recipe_name +'%"', (err, result) => {
        if(err){
          console.log('[SELECT ERROR] - ',err.message);
          return;
        }
        res.status(200).json(result);
    });
});

// get recipes by category_id
const getRecipesByCategory = `SELECT * FROM recipe WHERE recipe_id IN ( \
    SELECT recipe_id FROM recipe_category WHERE category_id = ( \
    SELECT category_id FROM category WHERE category_id = ? ) )`;
Router.get(apiUrl+'/getRecipesByCategory', (req, res) => {
    // console.log(JSON.stringify(req.body))
    dbConnection.query(getRecipesByCategory, [req.body.category_id], (err, result) => {
        if(err){
          console.log('[SELECT ERROR] - ',err.message);
          return;
        }
        res.status(200).json(result);
    });
});

// get all categories
const getAllCategories = `SELECT * FROM category WHERE 1=1`;
Router.get(apiUrl+'/getAllCategories', (req, res) => {
    dbConnection.query(getAllCategories, (err, result) => {
        if(err){
          console.log('[SELECT ERROR] - ',err.message);
          return;
        }
        res.status(200).json(result);
    });
});

// result example:
// [{
//         "category_id": 1,
//         "category_name": "chinese food"
// }]

//get ingredients by recipe_id
const getIngredientsByRecipeId = `SELECT * FROM ingredient WHERE ingredient_id IN(\
    SELECT ingredient_id from recipe_ingredient WHERE recipe_id = ?)`;
Router.get(apiUrl+'/getIngredientsByRecipeId', (req, res) => {
    dbConnection.query(getIngredientsByRecipeId, [req.body.recipe_id], (err, result) => {
        if(err){
          console.log('[SELECT ERROR] - ',err.message);
          return;
        }
        res.status(200).json(result);
    });
});

// result example:
// [{
//     "ingredient_id": 2,
//     "ingredient_name": "egg",
//     "calorie_per_100g": 147,
//     "ingredient_image": null
// }]

//get nutrition by recipe_id
const getNutritionbyRecipeId = `SELECT * FROM recipe_ingredient LEFT JOIN ingredient_nutrition \
    ON recipe_ingredient.ingredient_id = ingredient_nutrition.ingredient_id LEFT JOIN nutrition \
    ON ingredient_nutrition.nutrition_id = nutrition.nutrition_id \
    WHERE recipe_ingredient.recipe_id = ?`;
Router.get(apiUrl+'/getNutritionbyRecipeId', (req, res) => {
    dbConnection.query(getNutritionbyRecipeId, [req.body.recipe_id], (err, result) => {
        if(err){
          console.log('[SELECT ERROR] - ',err.message);
          return;
        }
        res.status(200).json(result);
    });
});

// result example:
// [{
//     "recipe_id": 1,
//     "ingredient_id": 2,
//     "quantity_g": 150, // the quantity of the ingredient (The unit of measurement is grams)
//     "nutrition_id": 1,
//     "amount_per_100g": 13, // the amount of that kind of nutrition per 100g
//     "nutrition_name": "protein" // the name of the nutrition
// }]

// add recipe to meal cart
const addRecipeToMealCart = `INSERT INTO meal_cart_recipe (meal_cart_id, recipe_id) VALUES(?,?)`;
Router.post(apiUrl+'/addRecipeToMealCart', (req, res) => {
    dbConnection.query(addRecipeToMealCart, [1,req.body.recipe_id], (err, result) => {
        if(err){
          console.log('[SELECT ERROR] - ',err.message);
          return;
        }
        res.status(200).json(result);
    });
});

// get meal cart by meal_cart_id
const getMealCartById = `SELECT * FROM meal_cart_recipe LEFT JOIN recipe \
    ON meal_cart_recipe.recipe_id = recipe.recipe_id \
    WHERE meal_cart_recipe.meal_cart_id = ?`;
Router.get(apiUrl+'/getMealCartById', (req, res) => {
    dbConnection.query(getMealCartById, [1], (err, result) => {
        if(err){
          console.log('[SELECT ERROR] - ',err.message);
          return;
        }
        res.status(200).json(result);
    });
});

// result example:
// [{
//     "meal_cart_id": 1,
//     "recipe_id": 1,
//     "recipe_name": "Stir-fried tomato with egg",
//     "recipe_description": null,
//     "prep_time": 5,
//     "cook_time": 10,
//     "recipe_subtitle": null,
//     "main_image": null,
//     "sub_image": null,
//     "calorie_per_100g": 74,
//     "create_time": null,
//     "update_time": null
// }]

//test/////////////////////////////////////////////////////////////////////////////////
const sql = 'SELECT * FROM testTable';
Router.get(apiUrl+'/test', function(req, res, next) {
    dbConnection.query(sql,function (err, result) {
        if(err){
          console.log('[SELECT ERROR] - ',err.message);
          return;
        }
       res.send(result);
    });
});

Router.get(apiUrl+'/uploadimage', function(req, res, next) {
    fs.readFile("public/images/test.png", (err, data) => {
        dbConnection.query(`INSERT INTO testImage (image) VALUES(?)`, data, (err, res) => {
            res.send("upload sucess");
        });
    });
});

Router.get(apiUrl+'/getimage', function(req, res, next) {
    fs.readFile("public/images/test.png", (err, data) => {
        dbConnection.query(`SELECT * FROM testImage`, function (err, result) {
            if(err){
              console.log('[SELECT ERROR] - ',err.message);
              return;
            }
            var buffer = new Buffer.from(result[0].image);
            var bufferBase64 = buffer.toString('base64');
            fs.writeFileSync(outputfile, bufferBase64);
            console.log("New file output:", outputfile);
            res.send("<img src='data:image/png;base64, "+ bufferBase64 +"'/>");
        });
    });
});

module.exports = Router;