from flask import Blueprint, request, jsonify
from .service import recipe_generate_service
from .dao import user_dao

bp = Blueprint('routes', __name__)
recipe_service = recipe_generate_service.RecipeGenerateService()
user_dao = user_dao.UserDao()


@bp.route('/api/v1/generateRecipes', methods=['POST'])
def generate_recipes():
    data = request.json
    if not data:
        return jsonify({"message": "No data provided in the request"}), 400

    user_id = data.get('_id')
    if not user_id:
        return jsonify({"message": "User ID not provided in the request"}), 400

    user_allergens = user_dao.get_user_allergies(user_id)
    if user_allergens is None:
        return jsonify({"message": f"No allergens found for user ID: {user_id}"}), 404

    user_ingredients = data.get('user_ingredients', [])
    if not user_ingredients:
        return jsonify({"message": "No user ingredients provided in the request"}), 400

    try:
        recommendations = []
        if user_ingredients and user_allergens:
            recommendations = recipe_service.generate_recommendations(user_allergens, user_ingredients)

        return recommendations

    except Exception as e:
        return jsonify({"message": f"An error occurred: {str(e)}"}), 500
