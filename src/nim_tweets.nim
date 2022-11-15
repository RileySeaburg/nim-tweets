# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.
import asyncdispatch
import db_postgres

import jester
routes: 
  get "/":
    resp "Hello World!"

runForever()