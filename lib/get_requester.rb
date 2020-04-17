require "net/http"
require "open-uri"
require "json"
require "pry"

def get_response_body(programming_language, city)
  language_name = programming_language.downcase.gsub(" ", "+")
  city_name = city.downcase.gsub(" ", "+")
  url = "https://jobs.github.com/positions.json?description=#{language_name}&location=#{city_name}"
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)
  response.body
end

def parse_json(programming_language, city)
  json = JSON.parse(get_response_body(programming_language, city))
  json.collect do |hash|
    hash
  end
end


