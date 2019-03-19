import os
from raven import Client

client = Client('http://{}@localhost:9000/3'.format(os.environ.get("SENTRY_AUTH_STRING")))

try:
    1 / 0
except ZeroDivisionError:
    client.captureException()