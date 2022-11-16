# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.
import asyncdispatch, times, database, views/user, views/general

import jester
routes: 
  get "/":
    resp renderMain(renderLogin())
    
  post "/login":
    setCookie("username", @"username", now() + 2.hours)
    redirect("/")

runForever()