from bson import ObjectId
from ..utils.config import mongo


class UserDao:

    def __init__(self):
        self.collection_name = "users"

    def get_user_allergies(self, user_id):
        try:
            query = {"_id": ObjectId(user_id)}
            user_allergies = mongo.db[self.collection_name].find_one(query).get("allergens",[])
            if user_allergies:
                return user_allergies
            else:
                return None

        except Exception as e:
            print(f"Error occurred while fetching user allergies: {str(e)}")
            return None
