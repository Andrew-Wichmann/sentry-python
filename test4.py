import os
from raven import Client

client = Client('http://{}@localhost:9000/3'.format(os.environ.get("SENTRY_AUTH_STRING")), tags={'FOOBAR':"BAZ"})

class CustomException3(Exception):
    pass

try:
    raise CustomException3
except CustomException3:
    client.captureException()