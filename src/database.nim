import times
# create a custom type to add a user to a database
type
  User* = object
    username*: string
    following*: seq[string]

  Message* = object 
    username*: string
    time*: Time
    msg*: string  

    