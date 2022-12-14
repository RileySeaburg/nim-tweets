# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.
import asyncdispatch, times, database, views/user, views/general
import jester

let db = newDatabase()
routes: 
  get "/":
    if request.cookies.hasKey("username"):
      var user: User
      if not db.findUser(request.cookies["username"], user):
        user = User(username: request.cookies["username"], following: @[])
        db.create(user)
      let messages = db.findMessages(user.following & user.username)
      resp renderMain(renderTimeline(user.username, messages))
    else:
      resp renderMain(renderLogin())
  post "/login":
    setCookie("username", @"username", now() + 2.hours)
    redirect("/")
  post "/createMessage":
    echo "username: ",  @"username", " message: ", @"message"
    let message = Message(
      username: @"username",
      time: now().toTime(),
      msg: @"message"
    )
    db.post(message)
    redirect("/")

runForever()