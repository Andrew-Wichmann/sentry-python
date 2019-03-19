import os
from raven import Client

client = Client('http://{}@localhost:9000/3'.format(os.environ.get("SENTRY_AUTH_STRING")))

class CustomException2(Exception):
    pass

try:
    foo="bar"
    raise CustomException2
except CustomException2:
    client.captureException()