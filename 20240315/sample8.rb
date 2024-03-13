require 'js'
require "cgi"

def console_log(message)
  puts "#{Time.now.strftime('%Y-%m-%d %H:%M:%S.%L')}: #{message}"
end

def output_html(message)
  output = JS.global[:document].getElementById("output")
  output[:innerHTML] = "#{output[:innerHTML]}#{CGI.escapeHTML(message)}<br>"
end

require 'net/http'

url = URI.parse('https://jsonplaceholder.typicode.com/todos/1')
response = Net::HTTP.get_response(url)

output_html "ステータスコード: #{response.code}"
output_html "レスポンスボディ: #{response.body}"
