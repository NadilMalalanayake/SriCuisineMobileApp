class PopularRecipe {
  final String name;
  final String image;
  final String cal;
  final String time;
  final String servings;
  final String ingredients;
  final String instructions;
  final String course;
  final String allergens;

  PopularRecipe({
    required this.name,
    required this.image,
    required this.cal,
    required this.time,
    required this.servings,
    required this.ingredients,
    required this.instructions,
    required this.course,
    required this.allergens, 
      });
}

 List<PopularRecipe> popularrecipes = [
  PopularRecipe(
    
  name: "Milk Tapioca",
  image: "assets/images/milk-tapioca.jpg",
  cal: "280",
  time: "45",
  servings: "4",
  ingredients: "Tapioca Pearls, Coconut Milk, Jaggery (or Brown Sugar), Cardamom Pods, Cashew Nuts, Raisins, Water",
  instructions: "1. Rinse tapioca pearls thoroughly and soak them in water for about 30 minutes.\n2. In a pot, combine soaked tapioca pearls with water and bring to a boil. Reduce heat and simmer until pearls are soft and translucent.\n3. In another pot, heat coconut milk with jaggery (or brown sugar) and crushed cardamom pods. Stir until jaggery is dissolved.\n4. Once tapioca pearls are cooked, pour the sweetened coconut milk mixture into the pot with tapioca.\n5. Stir well and simmer for another 5-10 minutes until the mixture thickens.\n6. In a separate pan, lightly fry cashew nuts and raisins until golden.\n7. Garnish the milk tapioca with fried cashew nuts and raisins.\n8. Serve warm or chilled as a delightful Sri Lankan dessert.",
  course: "Dessert",
  allergens: "Nuts",
),

  PopularRecipe(
    
  name: "Beef Curry",
  image: "assets/images/beef-curry.jpg",
  cal: "320",
  time: "45",
  servings: "4",
  ingredients: "Beef, Black Pepper, Salt, Curry Leaves, Coconut Milk, Onions, Garlic, Ginger, Green Chilli, Coriander Leaves, Lemon Juice, Oil, Water",
  instructions: "1. Heat oil in a pan and add curry leaves, onions, garlic, ginger, and green chili. Sauté for 2 minutes.\n2. Add beef, salt, and black pepper. Cook for 5 minutes.\n3. Pour in coconut milk. Simmer for 20 minutes until beef is tender.\n4. Stir in lemon juice and coriander leaves.\n5. Serve hot with rice.",
  course: "Main Course",
  allergens: "None",),

  PopularRecipe(
  
  name: "Sri Lankan Crab Curry",
  image: "assets/images/sri-lankan-crab-curry.jpg",
  cal: "350",
  time: "60",
  servings: "4",
  ingredients: "Crab, Black Pepper, Salt, Curry Leaves, Coconut Milk, Onions, Garlic, Ginger, Green Chilli, Tomato, Turmeric Powder, Red Chili Powder, Mustard Seeds, Vegetable Oil, Water",
  instructions: "1. Clean and prepare the crab by removing the outer shell and cutting it into pieces.\n2. In a pan, heat vegetable oil and add mustard seeds. Allow them to splutter.\n3. Add chopped onions, garlic, ginger, and green chili. Sauté until onions are golden brown.\n4. Stir in chopped tomatoes and cook until they turn mushy.\n5. Add turmeric powder, red chili powder, salt, and black pepper. Mix well.\n6. Pour in coconut milk and bring the curry to a gentle simmer.\n7. Add crab pieces and curry leaves. Cook for about 15-20 minutes until the crab is cooked through.\n8. Adjust seasoning if needed and serve hot with rice or bread.",
  course: "Main Course",
  allergens: "Shellfish",
  ),
  PopularRecipe(

  name: "Mango Curry",
  image: "assets/images/mango-curry.jpg",
  cal: "110",
  time: "30",
  servings: "4",
  ingredients: "mangoes, coconut milk, onions, garlic, minced ginger, grated green chilies, mustard seeds, turmeric powder, chili powder, coriander powder, Salt, oil, Curry leaves, coriander",
  instructions: "1.Heat oil in a pan over medium heat. Add mustard seeds and let them splutter. \n2. Add chopped onions, minced garlic, grated ginger, and green chilies. Sauté for 2 minutes.\n3. Add turmeric powder, chili powder, and coriander powder. Cook for 1 minute until fragrant.\n4. Add diced mangoes and cook for 5 minutes until they start to soften.\n5. Pour in coconut milk and season with salt. Cook for 5 minutes.\n6. Serve hot, garnished with curry leaves and fresh coriander leaves.",
  course: "Main Course",
  allergens: "None",
  ),

  PopularRecipe(
      name: "Coconut Rice Recipe",
      image: "assets/images/coconut-rice.jpg",
      cal: "100",
      time: "20",
      servings: "4",
      ingredients: "Rice, Coconut, Black Pepper, Salt, Curry Leaves, Coconut Milk, Onions, Garlic, Ginger, Green Chilli, Coriander Leaves, Lemon Juice, Oil, Water",
      instructions: "1. Heat oil in a pan and add curry leaves, onions, garlic, ginger, green chilli and saute it for 2 minutes.\n2. Add rice, salt, black pepper and cook for 5 minutes.\n 3. Add coconut milk and cook for 5 minutes.\n 4. Add lemon juice and coriander leaves.",
      course: "Main Course",
      allergens: "None",
),
  PopularRecipe(
      name: "Broccoli Curry",
      image: "assets/images/Broccoli Curry.jpg",
      cal: "90",
      time: "15",
      servings: "4",
      ingredients: "Broccoli, Black Pepper, Salt, Curry Leaves, Coconut Milk, Onions, Garlic, Ginger, Green Chilli, Coriander Leaves, Lemon Juice, Oil, Water",
      instructions: "1. Heat oil in a pan and add curry leaves, onions, garlic, ginger, green chilli and saute it for 2 minutes.\n2. Add broccoli, salt, black pepper and cook for 5 minutes.\n3. Add coconut milk and cook for 5 minutes.\n4. Add lemon juice and coriander leaves.\n 5. Serve hot with rice.",
      course: "Main Course",
      allergens: "None",
),
  PopularRecipe(
    
  name: "Black Chicken Curry",
  image: "assets/images/black-chicken-curry.jpg",
  cal: "380",
  time: "50",
  servings: "4",
  ingredients: "1. Coat chicken with black curry powder and salt.\n2, Let it sit for 30 minutes.\n3. Cook onion, garlic, ginger, and chilies in oil until fragrant. 4. Cook Chicken: Add marinated chicken, brown it, then pour in coconut milk. 5. Simmer for 20-25 minutes.",
  instructions: "1. Heat oil in a pan and add curry leaves, onions, garlic, ginger, green chilli and saute it for 2 minutes.\n2. Add chicken, salt, black pepper and cook for 5 minutes.\n3. Add coconut milk and cook for 5 minutes.\n4. Add lemon juice and coriander leaves.\n 5. Serve hot with rice.",
  course: "Main Course",
  allergens: "None",
)
];
