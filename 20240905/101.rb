# 6) setIntervalに関数渡す
require 'js'
require "cgi"

def console_log(message)
  puts "#{Time.now.strftime('%Y-%m-%d %H:%M:%S.%L')}: #{message}"
end

def output_html(message)
  output = JS.global[:document].getElementById("output")
  output[:innerHTML] = "#{output[:innerHTML]}#{CGI.escapeHTML(message)}<br>"
end

counter = 0
render = ->() {
  # clearIntervalの仕方がわからん
  return if counter >= 100

  console_log "loop #{counter}"
  output_html "loop #{counter}"
  counter += 1
}

# JavascriptのsetIntervalにrenderのprocを渡す
JS.global.call(:setInterval, JS.try_convert(render), 10)
