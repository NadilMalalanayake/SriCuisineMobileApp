from flask import Flask
from flask_cors import CORS
from app.main.routes import bp as routes_bp
from app.main.utils.config import config_by_name, mongo


def execute_app(config_name):
    app = Flask(__name__)
    CORS(app)  # enable CORS
    app.config.from_object(config_by_name[config_name])  # initialize configs (db credentials,tokens,...)
    mongo.init_app(app)  # initialize mongo db (pymongo)
    app.register_blueprint(routes_bp)  # register routes to app

    return app


if __name__ == "__main__":
    appr = execute_app('dev')
    appr.run(port=4000)
