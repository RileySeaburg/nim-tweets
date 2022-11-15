# Package

version       = "0.1.0"
author        = "RileySeaburg"
description   = "A twitter clone writter in Nim."
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["nim_tweets"]
skipExt       = @["nim"]


# Dependencies

requires "nim >= 1.6.8", "jester >= 0.0.1"