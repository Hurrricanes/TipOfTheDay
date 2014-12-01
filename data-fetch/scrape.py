import twitter
import hashlib
import mysql.connector
from unidecode import unidecode

__author__ = 'grainier'

# Setting up Twitter API
api = twitter.Api(
    consumer_key='9BwM6QRwC9C3iu1jrB0EtreCu',
    consumer_secret='HJQk6Ejro8OOVPQEk2HkoWOQubcvVuryD0pbKVVeDVIPC5n2Yb',
    access_token_key='100707620-DnnGcLY2GFTz8awMEthPn8WQCrkjyPvL0grAxeGD',
    access_token_secret='VkUrd6Cn846UBHBeV898dSG129xF1UovNPi1PJqGgfioo'
)
tweets = api.GetUserTimeline(screen_name='@quotepage', count=200)

config = {
    'user': 'root',
    'password': 'root',
    'host': '127.0.0.1',
    'database': 'tip_of_the_day',
}

db = mysql.connector.connect(**config)
cursor = db.cursor()
quotes = []

for tweet in tweets:
    text = tweet.text
    valid = len(text.split(' - ')) == 2 and True or False
    if valid:
        quote = text.split(' - ')[0].strip('"')
        author = text.split(' - ')[1].strip('"')

        sha_txt = ''.join(e for e in unidecode(text) if e.isalnum()).lower()
        sha = hashlib.sha1(sha_txt).hexdigest()
        q = {
            "tip": quote,
            "author": author,
            "sha": sha
        }
        sql = ("INSERT INTO tip (tip, author, sha) VALUES (%(tip)s, %(author)s, %(sha)s)")

        try:
            cursor.execute(sql, q)
            db.commit()
            pass
        except:
            pass
        pass
    pass
db.close()
