const asyncHandler = require("express-async-handler");
const Ingredient = require("../models/ingredient.model");
const logger = require("../utils/log4jsutil.js");
const AppError = require("../utils/app.error");

// @desc    Get expiring ingredients
// @route   GET /api/v1/ingredients
// @access  Public
const getIngredients = asyncHandler(async (req, res) => {
  const { userId } = req.body;
  logger.trace("[ingredientController] :: getIngredient() : Start");

  const oneDayFromNow = new Date();
  oneDayFromNow.setDate(oneDayFromNow.getDate() + 1);

  const threeDaysFromNow = new Date();
  threeDaysFromNow.setDate(threeDaysFromNow.getDate() + 3);

  const sevenDaysFromNow = new Date();
  sevenDaysFromNow.setDate(sevenDaysFromNow.getDate() + 7);

  // Find ingredients and categorize

  const ingredients = await Ingredient.find({
    user: userId,
    $or: [
      { expiryDate: { $lte: oneDayFromNow } },
      { expiryDate: { $lte: threeDaysFromNow, $gt: oneDayFromNow } },
      { expiryDate: { $lte: sevenDaysFromNow, $gt: threeDaysFromNow } },
    ],
  });
  console.log(ingredients);
  if (!ingredients || ingredients.length === 0) {
    return res.status(404).json({ message: "No ingredients found." });
  }

  const categorizedIngredients = {
    expiringToday: [],
    expiringIn3Days: [],
    expiringIn7Days: [],
    expired: [],
  };

  ingredients.forEach((ingredient) => {
    if (ingredient.expiryDate < oneDayFromNow) {
      categorizedIngredients.expired.push(ingredient);
    } else if (ingredient.expiryDate <= oneDayFromNow) {
      categorizedIngredients.expiringToday.push(ingredient);
    } else if (ingredient.expiryDate <= threeDaysFromNow) {
      categorizedIngredients.expiringIn3Days.push(ingredient);
    } else {
      categorizedIngredients.expiringIn7Days.push(ingredient);
    }
  });

  if (!categorizedIngredients) {
    res.status(200).json("No ingredients expiring within the next 7 days");
  }

  res.status(200).json(categorizedIngredients);

  logger.trace("[ingredientController] :: getIngredient() : end");
});

// @desc    Create a new ingredient
// @route   POST /api/v1/ingredients
// @access  Public
const createIngredient = asyncHandler(async (req, res) => {
  const { name, expiryDate, userId } = req.body;

  logger.trace("[ingredientController] :: createIngredient() : Start");

  try {
    // Create the ingredient
    const ingredient = await Ingredient.create({
      user: userId,
      name,
      expiryDate,
    });

    res.status(201).json(ingredient);
    logger.info(
      `[ingredientController] :: createIngredient() : Ingredientcreated successfully`
    );
  } catch (error) {
    logger.error(
      `[ingredientController] :: createIngredient() : Error creating ingredient: ${error.message}`
    );
    res.status(500).json({ message: "Server Error" });
  }

  logger.trace("[ingredientController] :: createIngredient() : End");
});

const createIngredientBatch = asyncHandler(async (req, res) => {
  logger.trace("[ingredientController] :: ingredientIngredientBatch() : Start");

  const ingredientData = req.body;

  if (!Array.isArray(ingredientData)) {
    logger.error(
      "[ingredientMeetingBatch] :: ingredientMeetingBatch() : Invalid data format"
    );
    throw new AppError(400, i18n("ERROR_INVALID_DATA_FORMAT"));
  }

  const createdIngredients = await Ingredient.insertMany(
    ingredientData.map((ingredientData) => ({
      user: ingredientData.user,
      expiryDate: ingredientData.expiryDate,
      name: ingredientData.name,
    }))
  );

  res.status(200).json(createdIngredients);

  logger.trace("[ingredientController] :: createIngredientBatch() : End");
});

// @desc    Update an ingredient
// @route   PUT /api/v1/ingredients/:id
// @access  Public
const updateIngredient = asyncHandler(async (req, res) => {
  const { name, expiryDate } = req.body;
  const AppError = require("../utils/app.error"); // Import here

  logger.trace("[ingredientController] :: updateIngredient() : Start");

  try {
    const ingredient = await Ingredient.findById(req.params.id);

    if (!ingredient) {
      logger.warn(
        `[ingredientController] :: updateIngredient() : Ingredient with ID ${req.params.id} not found`
      );
      throw new AppError("Ingredient not found", 404); // Throw AppError
    }

    ingredient.name = name;
    ingredient.expiryDate = expiryDate;

    await ingredient.save();

    res.status(200).json(ingredient);
    logger.info(
      `[ingredientController] :: updateIngredient() : Ingredient ${ingredient._id} updated successfully`
    );
  } catch (error) {
    logger.error(
      `[ingredientController] :: updateIngredient() : Error updating ingredient: ${error.message}`
    );

    // Determine appropriate error response (assuming AppError structure)
    if (error instanceof AppError) {
      res.status(error.statusCode).json({ message: error.message });
    } else {
      res.status(500).json({ message: "Server Error" });
    }
  }

  logger.trace("[ingredientController] :: updateIngredient() : End");
});

// @desc    Delete an ingredient
// @route   DELETE /api/v1/ingredients/:id
// @access  Public
const deleteIngredient = asyncHandler(async (req, res) => {
  logger.trace("[ingredientController] :: deleteIngredient() : Start");

  try {
    const ingredient = await Ingredient.findById(req.params.id);

    if (!ingredient) {
      logger.warn(
        `[ingredientController] :: deleteIngredient() : Ingredient with ID ${req.params.id} not found`
      );
      throw new AppError("Ingredient not found", 404); // Throw AppError
    }

    await ingredient.remove();

    res.status(200).json({ message: "Ingredient deleted successfully" });
    logger.info(
      `[ingredientController] :: deleteIngredient() : Ingredient ${ingredient._id} deleted successfully`
    );
  } catch (error) {
    logger.error(
      `[ingredientController] :: deleteIngredient() : Error deleting ingredient: ${error.message}`
    );

    // Determine appropriate error response (assuming AppError structure)
    if (error instanceof AppError) {
      res.status(error.statusCode).json({ message: error.message });
    } else {
      res.status(500).json({ message: "Server Error" });
    }
  }

  logger.trace("[ingredientController] :: deleteIngredient() : End");
});

module.exports = {
  getIngredients,
  createIngredient,
  updateIngredient,
  deleteIngredient,
  createIngredientBatch,
};

