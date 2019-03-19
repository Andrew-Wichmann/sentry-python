import os
from raven import Client

client = Client('http://{}@localhost:9000/3'.format(os.environ.get("SENTRY_AUTH_STRING")))

class CustomException(Exception):
    pass

try:
    raise CustomException
except CustomException:
    client.captureException()