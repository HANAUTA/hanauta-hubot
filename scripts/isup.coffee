# Description:
#   Uses downforeveryoneorjustme.com to check if a site is up
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot is <domain> up? - Checks if <domain> is up
#
# Author:
#   jmhobbs

module.exports = (robot) ->
  robot.respond /is (?:http\:\/\/)?(.*?) (up|down)(\?)?/i, (msg) ->
    isUp msg, msg.match[1], (domain) ->
      msg.send domain

isUp = (msg, domain, cb) ->
  msg.http("http://isitup.org/#{domain}.json")
  .header('User-Agent', 'Hubot')
  .get() (err, res, body) ->
    response = JSON.parse(body)
    if response.status_code is 1
      cb "#{response.domain} はアクセスできます"
    else if response.status_code is 2
      cb "#{response.domain} はダウンしているようです"
    else if response.status_code is 3
      cb "'#{response.domain}' は無効なドメインのようです"
    else
      msg.send "#{response.domain} はエラーを返しました"