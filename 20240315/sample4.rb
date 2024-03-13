require 'js'
require "cgi"

def console_log(message)
  puts "#{Time.now.strftime('%Y-%m-%d %H:%M:%S.%L')}: #{message}"
end

def output_html(message)
  output = JS.global[:document].getElementById("output")
  output[:innerHTML] = "#{output[:innerHTML]}#{CGI.escapeHTML(message)}<br>"
end

Dir.foreach(__dir__) do |file|
  output_html file
end
