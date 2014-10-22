# Description:
#   hogehoge.
#
# Commands:
#   weather: piyopiyo.

conditions =
  "Thunderstorm": "雷雨",
  "Drizzle": "小雨",
  "Rain": "雨",
  "Snow": "雪",
  "Clouds": "曇り",
  "Clear": "晴れ"

module.exports = (robot) ->

  robot.respond /weather ?(.*)$/i, (msg) ->

    # パラメーターがなければ Shibuya を地名に指定する
    city = if msg.match[1].length > 0 then msg.match[1] else "Shibuya"

    robot.http("http://api.openweathermap.org/data/2.5/weather?q=#{city}")
      .query({})
      .get() (err, res, body) ->

        try
          weather = JSON.parse(body)
        catch error
          msg.send "JSONをパースできませんでした＞＜ (Error: #{error})"
          return

        switch parseInt(weather.cod, 10)
          when 404
            msg.send "#{city} は存在しません＞＜"

          when 200
            # 天気のタイトル
            main_condition = weather["weather"][0]["main"] ? undefined
            if main_condition?
              # 日本語訳があれば変換、なければ英語
              translated_condition = conditions[main_condition] ? main_condition
              msg.send "#{city} の天気 #{translated_condition}"

          else
            if weather.message
              msg.send "#{weather.cod} : #{weather.message}"
            else
              msg.send "天気を取得できませんでした＞＜ (Code: #{weather.cod}, City: #{city})"
