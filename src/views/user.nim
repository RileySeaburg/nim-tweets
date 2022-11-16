#? stdtmpl(subsChar = '$', metaChar = '#', toString = "xmltree.escape")                       
#import "../database"                                            
#import xmltree
#import times
#                                                                
#proc renderUser*(user: User): string =
#  result = ""                                                   
<div id="user">                                                  
  <h1>${user.username}</h1>
  <span>${$user.following.len}</span>
</div>
#end proc                                                        
#
#when isMainModule:
#  echo renderUser(User(username: "d0m96", following: @[]))
#end when
#
#
#proc renderUser*(user: User, currentUser: User): string =
#  result = ""
<div id="user">
  <h1>${user.username}</h1>
  <span>${$user.following.len}</span>
  #if user.username notin currentUser.following:
  <form action="follow" method="post">
    <input type="hidden" name="follower" value="${currentUser.username}" />
    <input type="hidden" name="target" value="${user.username}" />
    <input type="submit" value="Follow" />
  </form>
  #end if
</div>
#
#end proc
#
#proc renderMessages*(messages: seq[Message]): string =
#  result = ""
<div id="messages">
  #for message in messages:
  <div class="message">
    <a href="/${message.username}">${message.username}</a>
    <span>${message.time.format("yyyy-MM-dd HH:mm:ss")}</span>
    <p>${message.msg}</p>
  </div>
  #end for
</div>
#end proc
#
#when isMainModule:
#  echo renderUser(User(username: "d0m96<>", following: @[]))
#  echo renderMessages(@[
#    Message(username: "d0m96", time: getTime(), msg: "Hello, world!"),
#    Message(username: "d0m96", time: getTime(), msg: "Testing..."),
#  ])
#end when