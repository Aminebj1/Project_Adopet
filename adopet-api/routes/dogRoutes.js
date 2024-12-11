const express = require('express');
const Dog = require('../models/dog');
const router = express.Router();
const mongoose = require('mongoose');  // Importation de mongoose


router.post('/dogs', async (req, res) => {
  const { name, age, gender, color, weight, distance, imageUrl, description, owner } = req.body;

  try {
    const newDog = new Dog({ name, age, gender, color, weight, distance, imageUrl, description, owner });
    await newDog.save();
    res.status(201).json(newDog);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// GET all dogs
router.get('/dogs', async (req, res) => {
  try {
    const dogs = await Dog.find();
    res.status(200).json(dogs);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});


router.put('/dogs/:id', async (req, res) => {
  const { id } = req.params;
  const { name, age, gender, color, weight, distance, imageUrl, description, owner } = req.body;

  try {
    const updatedDog = await Dog.findByIdAndUpdate(id, { name, age, gender, color, weight, distance, imageUrl, description, owner }, { new: true });
    if (!updatedDog) return res.status(404).json({ message: 'Dog not found' });
    res.status(200).json(updatedDog);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});


// DELETE a dog by ID
router.delete('/dogs/:id', async (req, res) => {
  const { id } = req.params;

  // Check if the ID is valid before attempting to convert it to ObjectId
  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ message: 'Invalid Dog ID format' });
  }

  try {
    // Attempt to delete the dog by ID
    const deletedDog = await Dog.findByIdAndDelete(id);
    if (!deletedDog) {
      return res.status(404).json({ message: 'Dog not found' });
    }
    res.status(200).json({ message: 'Dog deleted successfully' });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});
module.exports = router;
