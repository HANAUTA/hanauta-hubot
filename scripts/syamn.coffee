# Description:
#   Utility commands surrounding Hubot uptime.
#
# Commands:
#   hubot who are you - Reply with pong

module.exports = (robot) ->
  robot.respond /who are you/i, (msg) ->
    msg.send "I'm hubot hosting by Sakura Onishi!"