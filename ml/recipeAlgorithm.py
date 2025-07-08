import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity
from sklearn.feature_extraction.text import CountVectorizer

# Load the dataset
try:
    df = pd.read_csv("Demo_IndianFoodDataset.csv", encoding="utf-8")
except UnicodeDecodeError:
    df = pd.read_csv("Demo_IndianFoodDataset.csv", encoding="latin1")


# Let the user enter their allergies and ingredients
user_allergens = input("Enter your allergies (comma-separated): ").strip().split(",")
user_ingredients = input("Enter the ingredients you have at home (comma-separated): ").strip().split(",")

# Filter out recipes containing the user's allergens
if len(user_allergens) == 1:
    df = df[~df['Allergens'].str.contains(user_allergens[0], na=False)]
elif len(user_allergens) == 2:
    df = df[~df['Allergens'].str.contains(user_allergens[0], na=False) & ~df['Allergens'].str.contains(user_allergens[1], na=False)]

# Drop rows with missing values in the 'Ingredients' column
df = df.dropna(subset=['Ingredients'])

# Combine all ingredients into one string for each recipe
df['Ingredients_str'] = df['Ingredients'].apply(lambda x: ' '.join(x.split(', ')))

# Combine user allergens and ingredients into one list
user_allergens.extend(user_ingredients)
user_input = ', '.join(user_allergens)

# Combine user input with recipe ingredients
all_ingredients = df['Ingredients_str'].tolist()
all_ingredients.append(user_input)

# Vectorize ingredients using CountVectorizer
vectorizer = CountVectorizer()
X = vectorizer.fit_transform(all_ingredients)

# Calculate cosine similarity
cosine_sim = cosine_similarity(X[:-1], X[-1])

# Add cosine similarity to the DataFrame
df['CosineSimilarity'] = cosine_sim.flatten()

# Sort recipes by cosine similarity in descending order
df = df.sort_values(by='CosineSimilarity', ascending=False)

# Display top ten relevant records for recommended recipes
print("Recommended Recipes:")
print(df[['Srno', 'RecipeName', 'Ingredients', 'TotalTimeInMins', 'Instructions']].head(10))
