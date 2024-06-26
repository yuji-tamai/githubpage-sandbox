# 3) 擬似変数出してみた
require 'js'
require "cgi"

def console_log(message)
  puts "#{Time.now.strftime('%Y-%m-%d %H:%M:%S.%L')}: #{message}"
end

def output_html(message)
  output = JS.global[:document].getElementById("output")
  output[:innerHTML] = "#{output[:innerHTML]}#{CGI.escapeHTML(message)}<br>"
end

output_html "__FILE__ = #{__FILE__.inspect}"
output_html "__dir__ = #{__dir__.inspect}"
output_html "__LINE__ = #{__LINE__.inspect}"
output_html "__ENCODING__ = #{__ENCODING__.inspect}"
