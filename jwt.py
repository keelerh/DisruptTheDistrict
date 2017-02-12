import datetime
import jwt

# Replace these with your details
CONSUMER_KEY = 'f34c1ebec034484c950e1dfcbc871da2'
CONSUMER_SECRET = '943a0cf0-d6bb-4902-8ef3-3ad385ec5075'

# Only change this if you're sure you know what you're doing
CONSUMER_TTL = 86400

def generate_token(user_id):
    return jwt.encode({
      'consumerKey': CONSUMER_KEY,
      'userId': user_id,
      'issuedAt': _now().isoformat() + 'Z',
      'ttl': CONSUMER_TTL
    }, CONSUMER_SECRET)

def _now():
    return datetime.datetime.utcnow().replace(microsecond=0)

print generate_token(123)
