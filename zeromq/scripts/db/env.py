from os import environ
from dotenv import load_dotenv

load_dotenv()  # take environment variables from .env.


DB_CONNECTION = environ.get('DB_CONNECTION')
DB_SCHEMA = environ.get('DB_SCHEMA')
