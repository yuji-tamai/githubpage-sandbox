# 7) Fiber使ってみた
require 'js'
require "cgi"

def console_log(message)
  puts "#{Time.now.strftime('%Y-%m-%d %H:%M:%S.%L')}: #{message}"
end

def output_html(message)
  output = JS.global[:document].getElementById("output")
  output[:innerHTML] = "#{output[:innerHTML]}#{CGI.escapeHTML(message)}<br>"
end

f3 = Fiber.new do
  n = 1
  loop do
    Fiber.yield(n * 3)
    n += 1
  end
end

f7 = Fiber.new do
  n = 1
  loop do
    Fiber.yield(n * 7)
    n += 1
  end
end

5.times do |i|
  output_html "3x#{i+1}= #{f3.resume}"
  output_html "7x#{i+1}= #{f7.resume}"
end
