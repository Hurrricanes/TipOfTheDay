import twitter
import hashlib
import MySQLdb

__author__ = 'grainier'

# Setting up Twitter API
api = twitter.Api(
    consumer_key='9BwM6QRwC9C3iu1jrB0EtreCu',
    consumer_secret='HJQk6Ejro8OOVPQEk2HkoWOQubcvVuryD0pbKVVeDVIPC5n2Yb',
    access_token_key='100707620-DnnGcLY2GFTz8awMEthPn8WQCrkjyPvL0grAxeGD',
    access_token_secret='VkUrd6Cn846UBHBeV898dSG129xF1UovNPi1PJqGgfioo'
)
tweets = api.GetUserTimeline(screen_name='@quotepage', count=200)
db = MySQLdb.connect("localhost", "root", "root", "tip_of_the_day")
cursor = db.cursor()
quotes = []

for tweet in tweets:
    text = tweet.text
    valid = len(text.split(' - ')) == 2 and True or False
    if valid:
        quote = text.split(' - ')[0].strip('"')
        author = text.split(' - ')[1].strip('"')
        sha = hashlib.sha1(text).hexdigest()
        quotes.append({
            "quote": quote,
            "author": author,
            "sha": sha
        })
        sql = "INSERT INTO tip(tip, author, sha) VALUES ('%s', '%s', '%s')" % (quote, author, sha)

        try:
            cursor.execute(sql)
            db.commit()
            pass
        except:
            db.rollback()
            pass
        pass
    pass
db.close()
