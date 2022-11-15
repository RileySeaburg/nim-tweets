import  db_sqlite

var db = open("nim_tweets.db". "", "", "")


db.exec(sql"""
  CREATE TABLE IF NOT EXISTS Following(
    follower text,
    followed_user text,
    PRIMARY_KEY ()
  )
)

db.close()