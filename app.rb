require "sinatra"
require "sinatra/reloader"
require "httparty"
def view(template); erb template.to_sym; end

get "/" do
  ### Get the weather
  # Evanston, Kellogg Global Hub... replace with a different location if you want
  #lat = 42.0574063
  #long = -87.6722787
  #San Diego, California
  #lat = 32.7157
  #long = -117.1611

  #units = "imperial" # or metric, whatever you like
  #key = "7fb66a2e93b68621bf5b53ee9e14e28b" # replace this with your real OpenWeather API key

  # construct the URL to get the API data (https://openweathermap.org/api/one-call-api)
  #url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{long}&units=#{units}&appid=#{key}"
  url = "https://api.openweathermap.org/data/2.5/onecall?lat=32.7157&lon=-117.1611&units=imperial&appid=7fb66a2e93b68621bf5b53ee9e14e28b"

  # make the call
  @forecast = HTTParty.get(url).parsed_response.to_hash
  @current_temp = "It is currently #{@forecast["current"]["temp"]} degrees with #{@forecast["current"]["weather"][0]["description"]} in San Diego, California."
  @daily_temp = "Tomorrow's forecast is a high of #{@forecast["daily"][1]["temp"]["max"]} with a low of #{@forecast["daily"][1]["temp"]["min"]}"
  
  
  ### Get the news
  url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=e744a6378f0b484d86094e76f27798f3"
  #make the call 
  @news = HTTParty.get(url).parsed_response.to_hash
  @article_one = "#{@news["articles"][1]["title"]}"
  @source_one = "#{@news["articles"][1]["url"]}"
  @article_two = "#{@news["articles"][2]["title"]}"
  @source_two = "#{@news["articles"][2]["url"]}"
  @article_three = "#{@news["articles"][3]["title"]}"
  @source_three = "#{@news["articles"][3]["url"]}"


  view "news"

end
