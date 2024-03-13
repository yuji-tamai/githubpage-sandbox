require 'js'
require "cgi"

def console_log(message)
  puts "#{Time.now.strftime('%Y-%m-%d %H:%M:%S.%L')}: #{message}"
end

def output_html(message)
  output = JS.global[:document].getElementById("output")
  output[:innerHTML] = "#{output[:innerHTML]}#{CGI.escapeHTML(message)}<br>"
end

def document
  @document ||= JS.global[:document]
end

def execute_ruby_code(code)
  start = Time.now
  result = eval(code)
  elapsed = Time.now - start
  output_html "Result: #{result}"
  output_html "Time: #{elapsed} sec"
rescue Exception => e
  output_html "Error: #{e.message}"
end

button = document.getElementById('executeButton')

button.addEventListener 'click' do |_e|
  ruby_code = document.getElementById('rubyCode')[:value].to_s
  execute_ruby_code(ruby_code)
end
