import times, db_sqlite, strutils
# create a custom type to add a user to a database


type
  Database* = ref object 
    db: DbConn

proc newDatabase*(filename = "nim_tweets.db"): Database =
  new result
  result.db = open(filename, "", "", "")

type
  User* = object
    username*: string
    following*: seq[string]

  Message* = object 
    username*: string
    time*: Time
    msg*: string  

proc post*(database: Database, message: Message) =
  if message.msg.len > 140:
    raise newException(ValueError, "Messagehas to be less than 140 characters.")

  database.db.exec(sql"INSERT INTO Message VALUES (?,?,?);",
    message.username, $message.time.toUnixFloat().int, message.msg)

proc follow*(database: Database, follower: User, user: User) = 
  database.db.exec(sql"INSERT INTO Following VALUES (?, ?);",
    follower.username, user.username)

proc create*(database: Database, user: User) =
  database.db.exec(sql"INSERT INTO User Values (?);", user.username)


proc findUser*(database: Database, username: string, user: var User): bool =
  let row = database.db.getRow(
      sql"SELECT username FROM User WHERE username = ?;", username)
  if row[0].len == 0: return false
  else: user.username = row[0]
  #  describe followers
  let following = database.db.getAllRows(
    sql"SELECT followed_user FROM Following WHERE follower = ?;", username)
  user.following = @[]
  for row in following:
    if row[0].len != 0:
      user.following.add(row[0])
  return true

# Get tweets
proc findMessages*(database: Database, usernames: seq[string],
    limit = 10): seq[Message] =
  result = @[]
  if usernames.len == 0: return
  var whereClause = " WHERE "
  for i in 0 .. usernames.len:
    whereClause.add("username = ? ")
    if i != usernames.len:
      whereClause.add("or ")

  let messages = database.db.getAllRows(
      sql("SELECT username, time, msg FROM Message" &
          whereClause &
          "ORDER BY time DESC LIMIT " & $limit),
      usernames)
  for row in messages:
    result.add(Message(username: row[0], time: fromUnixFloat(row[1].parseFloat()),
      msg: row[2]))