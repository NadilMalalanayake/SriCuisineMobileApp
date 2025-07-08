from flask_pymongo import PyMongo


class DevelopmentMode:
    MONGO_URI = "mongodb+srv://admin:admin123@devtaminapi.xbj96ay.mongodb.net/test"
    MONGO_DBNAME = 'test'
    DEBUG = True


class TestingMode:
    MONGO_URI = "mongodb+srv://AnujanR:4rW0ZaiPmBtkbrXA@evoar.qcmphjl.mongodb.net/?retryWrites=true&w=majority"
    MONGO_DBNAME = None
    DEBUG = False


class ProductionMode:
    MONGO_URI = "mongodb+srv://admin:admin123@devtaminapi.xbj96ay.mongodb.net/test"
    MONGO_DBNAME = 'test'
    DEBUG = False


config_by_name = dict(
    dev=DevelopmentMode,
    test=TestingMode,
    prod=ProductionMode
)

# Initialize PyMongo
mongo = PyMongo()
