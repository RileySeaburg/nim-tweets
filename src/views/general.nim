#? stdtmpl(subsChar = '$', metaChar = '#')
#import "../database"
#import user
#import xmltree
#
#proc `$!` (text: string): string = escape(text)
#end proc
#
#proc renderMain*(body: string): string =
# result = ""
<!DOCTYPE html>
<html>

  <head>
    <title>My Page</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/css/bootstrap.min.css"
      integrity="sha384-r4NyP46KrjDleawBgD5tp8Y7UzmLA05oM1iAEQ17CSuDqnUK2+k9luXQOfXJCJ4I" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
      integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
      crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/js/bootstrap.min.js"
      integrity="sha384-oesi62hOLfzrys4LxRF63OJCXdXDipiYWBnvTl9Y9/TRlw5xlKIEHpNyvvDShgf/"
      crossorigin="anonymous"></script>
    <link rel='stylesheet' href='style.css'>
  </head>

  <body class="">
    <div id="main" class="d-flex justify-content-center flex-column align-middle" style="height: 100vh">
      ${body}
    </div>
  </body>

</html>
#end proc
#
# proc renderLogin*(): string =
# result = ""
<div id="login" class=" d-flex justify-content-center ">
  <form action="/login" method="post" class="d-flex justify-content-center flex-column">
    <div class="form-group">
      <label for="username">Username</label>
      <input type="text" class="form-control " id="username" name="username" placeholder="Enter username">
    </div>
    <div class="form-group">
      <label for="password">Password</label>
      <input type="password" class="form-control " id="password" name="password" placeholder="Password">
    </div>
    <button type="submit" class="btn btn-primary">Submit</button>
  </form>
</div>
# end proc
#
#proc renderTimeline*(username: string, messages: seq[Message]): string =
# result = ""
<div id="user">
  <h1>${$!username}'s timeline</h1>
</div>
<div id="newMessage">
  <span>New message</span>
  <form action="createMessage" method="post">
    <input type="text" name="message">
    <input type="hidden" name="username" value="${$!username}">
    <input type="submit" value="Tweet">
  </form>
</div>
${renderMessages(messages)}
#end proc