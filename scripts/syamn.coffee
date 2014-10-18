# Description:
#   Utility commands surrounding Hubot uptime.
#
# Commands:
#   hubot who are you - Reply with pong

module.exports = (robot) ->
  robot.respond /who are you/i, (msg) ->
    msg.send "I'm hubot hosting by Sakura Onishi!"

  robot.respond /omikuji$/i, (msg) ->
    msg.send(msg.message.user.name + "の運勢: " + msg.random(['大吉','中吉','小吉','末吉','凶',]))